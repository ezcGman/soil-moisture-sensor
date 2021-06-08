#include <ESP8266WiFi.h>
// Using https://pubsubclient.knolleary.net/
#include <PubSubClient.h>
// Using https://github.com/mcxiaoke/ESPDateTime
#include <DateTime.h>


const char* ssid     = "YourSSID";
const char* password = "YourWiFiPassword";

const char* mqttServer = "YourMQTTServer";
const int mqttPort = 1883;
const char* mqttUser = "YourMQTTUser";
const char* mqttPassword = "YourMQTTPassword";

// https://github.com/esp8266/Arduino/blob/master/variants/nodemcu/pins_arduino.h
const byte analogMoisturePin = A0;
const byte enableSensorPin = 4;

// Measured myself, using this guide: https://media.digikey.com/pdf/Data%20Sheets/DFRobot%20PDFs/SEN0193_Web.pdf
const int airValue = 910;
const int waterValue = 412;
// The original script devides into "Very wet", "Wet" and "Dry". But we will only care about "Dry", but we keep the sectioning
// int intervals = (airValue - waterValue) / 3;
// I on the other hand thought that maybe 60% on the way to the air value may be considered "dry":
// const int plantDryThreshold = ((airValue - waterValue) * 0.6) + waterValue;
// But my girlfriend said "This now is dry!". And "this" was around the 570 mark. And girls are always right ¯\_(ツ)_/¯
// Even if I think that we should set the threshold to 570 then, I still go ahead and set it to 550, to have the alert trigger a bit earlier.
// Yes, that should be in the alerting systems business logic, but we use this boolean flag in the alerting. So we set this flag a little earlier.
const int plantDryThreshold = 550;

const byte maxConnTries = 15;

WiFiClient wifiClient;
PubSubClient mqttClient(wifiClient);


void connectWifi() {
  if (WiFi.status() != WL_CONNECTED) {
    int wifiConnTries = 0;

    WiFi.mode(WIFI_STA);
    WiFi.setSleepMode(WIFI_LIGHT_SLEEP);
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED && wifiConnTries < maxConnTries) {
      wifiConnTries++;
      Serial.printf("Connecting to Wi-Fi %s ...\n", ssid);
      delay(1000);
    }

    if (WiFi.status() != WL_CONNECTED && wifiConnTries >= maxConnTries) {
      Serial.println("Maximum number of Wi-Fi connection attempts reached. Rebooting...");
      ESP.restart();
    }

    Serial.printf("Connected to Wi-Fi! IP address: %s\n", WiFi.localIP().toString().c_str());
  }
}

void connectMqtt() {
  if (!mqttClient.connected()) {
    int mqttConnTries = 0;
    while (!mqttClient.connected() && mqttConnTries < maxConnTries) {
      mqttConnTries++;
      Serial.printf("Connecting to MQTT server at %s on port %d ...\n", mqttServer, mqttPort);

      if (!mqttClient.connect("esp8266-doorbell", mqttUser, mqttPassword )) {
        Serial.print("Failed with state ");
        Serial.println(mqttClient.state());
        delay(1000);
      }
    }

    if (!mqttClient.connected() && mqttConnTries >= maxConnTries) {
      Serial.println("Maximum number of MQTT connection attempts reached. Rebooting...");
      ESP.restart();
    }

    Serial.println("Connected to MQTT server!");
  }
}

// Sometimes values can go over or under our thresholds, so we just cap them on both ends to have meaningful percentage values
float sanitizeSoilMoistureValue(float soilMoistureValue) {
  if (soilMoistureValue < waterValue && soilMoistureValue > 0) {
    soilMoistureValue = waterValue;
  }
  else if (soilMoistureValue > airValue) {
    soilMoistureValue = airValue;
  }

  return soilMoistureValue;
}

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(enableSensorPin, OUTPUT);

  digitalWrite(LED_BUILTIN, LOW);
  digitalWrite(enableSensorPin, HIGH);

  Serial.begin(9600);

  // The Wi-FI library has auto-reocnnect. So we simply call it in setup() and there is no need to always check the conenction in loop()
  connectWifi();

  mqttClient.setServer(mqttServer, mqttPort);
  connectMqtt();

  float soilMoistureValue = analogRead(analogMoisturePin);
  Serial.printf("Raw value: %f\n", soilMoistureValue);

  soilMoistureValue = sanitizeSoilMoistureValue(soilMoistureValue);
  Serial.printf("Sanitized value: %f\n", soilMoistureValue);

  char charMoistureValue[4];
  int intMoistureValue = soilMoistureValue;
  sprintf(charMoistureValue, "%d", intMoistureValue);
  mqttClient.publish("home-assistant/plant-sensors/balcony/tomato/moisture", charMoistureValue, true);

  float wetPercentage = 100 - ((soilMoistureValue - waterValue) / (airValue - waterValue) * 100);

  Serial.printf("Wet Percentage: %.2f\%\n", wetPercentage);
  char charWetPercentage[7];
  sprintf(charWetPercentage, "%.2f", wetPercentage);
  mqttClient.publish("home-assistant/plant-sensors/balcony/tomato/wet-percentage", charWetPercentage, true);

  int isWet = 1;
  if(soilMoistureValue > plantDryThreshold) {
    isWet = 0;
  }
  Serial.printf("Is wet: %d\n", isWet);

  char charIsWet[1];
  sprintf(charIsWet, "%d", isWet);
  mqttClient.publish("home-assistant/plant-sensors/balcony/tomato/wet", charIsWet, true);

  DateTime.begin();
  int dateTimeTries = 0;
  while (!DateTime.isTimeValid() && dateTimeTries < 3) {
      dateTimeTries++;
      Serial.println("Failed to get time from server.");
  }
  String strDateTime = DateTime.format("%Y-%m-%dT%H:%M:%S%z");
  char charDateTime[strDateTime.length()];
  strDateTime.toCharArray(charDateTime, strDateTime.length());
  mqttClient.publish("home-assistant/plant-sensors/balcony/tomato/lastUpdated", charDateTime, true);

  digitalWrite(enableSensorPin, LOW);
  digitalWrite(LED_BUILTIN, LOW);

  delay(100);
  ESP.deepSleep(15*60e6); // Deep Sleep for 15 minutes
}

void loop() {
}

![The PCB](https://github.com/ezcGman/soil-moisture-sensor/blob/master/pictures/SoilMoistureSensor.png?raw=true)

# Soil Moisture Sensor
This is one of my first self designed PCBs in KiCad. It's a simple circuit which makes use of an ESP8266 and a soil moisture sensor to observe your plants. The cool thing: My custom socket supports the ESP-12E/F, the ESP-8 and the cool ESP-7, which comes with an external antennna!

## Credits
Shout out to Quindor from QuinLED.info, the LED master himself. He tought me a lot about KiCad, PCB design and some more electrical engineering fundamentals! While I'm still miles away from being perfect, with his help I really feel really confident in what I'm doing here!

## Parts list
All these parts can be easily found on AliExpress (except the PCBs ;) ):

- 1x The PCB in this folder, printed e.g. at PCBWay
- 1x 3.2V LiFePO4 battery in AA form factor
- 1x AA battery holder for THT mounting
- 1x capactive soil moisture sensor (some notes on capacitive vs. resistive sensors can be found a bit further down)
- 1x bare ESP8266 module, so no devboard like the famous NodeMCU or D1 Mini. The socket supports the ESP-12E/F, ESP-8 and ESP-7. But in the end, there are only two choices:
  - ESP-12E/F: If you don't need an external antenna / your Wi-Fi signal is good, get this one. It's super common, easy to get and cheap.
  - ESP-7: If you do need an external antenna, get this one. Often also comes directly with an antenna! 
- 1x NPN transistor. Probably most transistors are fine, but I suggest the 2n2222(a) which is super common and totally sufficient for this
- 1x 0805 SMD capacitor of 10µF or bigger. But 0805 SMD caps are usually limited to ~40µF. So whatever u have around
- 1x 0805 SMD capacitor of 100nF
- 1x 0805 resistor of 1kΩ
- 2x 0805 resistor of 10kΩ
- 1x 0805 resistor of 100kΩ
- 1x 0805 resistor of 220kΩ
- 2x **2mm** (**not** 2.54mm!!) single row pin headers of 8 pins each
- 1x 2.54mm single row pin header of 3 pins

## Tools list
### Required
- A soldering iron
- Soldering tin

### Optional
- For SMD components:
  - A hot air soldering/reflow station. However, those are 0805 SMD components which can be done with a soldering iron
  - Solder paste
  - Tweezers

## The code
If you're familiar with ESP coding, this should all be straight forward, but some key things in there:
* The whole code is in setup() as the ESP goes through it when doing timed deep sleep using the GPIO16-to-RST method. Because the "wake up" is actually a reset, because the RST in is pulled low.
* I'm using the sensor in Home Assistant through MQTT, so the code has tome MQTT logic
* Both my Wi-Fi and MQTT connect routines have some reconnect logic.
* GPIO4 is used to switch on the sensor, so this is one of the very first things the code does. This is done by pulling it HIGH, which will switch the transistor which then makes the full circuit of the sensor complete, by letting the electrones flow from GND to the sensor.
* I then just read from the A0 pin, convert it in C-super-complicated-style (Python developer speaking here!) to a char and dropping it into an MQTT topic.
* It also has some percentage calculation, which is based on my own measurements of the sensor. These are the "air value" (so sensor just laying around) and the "water value" (which is the sensor put into a glas of clear water).
* Another thing is a "dry/wet threshold", which is based on my girlfriend: She said "Andy, this is now dry!". And I took this as the threshold (minus a little bit for earlier alerts) for considering a plant being dry. Note, that this may vary by plant and flower soil used.
* Ultimately not needed, but for easier checking if the battery is empty (=no signal is sent anymore): A "last updated" timestamp also dropped into the MQTT topic

### Dependencies
* Arduino Client for MQTT, >=v2.8.0: https://pubsubclient.knolleary.net/
* Optional (can use built-in DateTime): ESPDateTime, >=v1.0.4: https://github.com/mcxiaoke/ESPDateTime

## Schematic
![The Schematic](https://github.com/ezcGman/soil-moisture-sensor/blob/master/pictures/SoilMoistureSensor-Schematic.png?raw=true)

## Why a bare ESP-12F, why not using a devboard like D1 or NodeMCU?
Easy answer: Power consumption + deep sleep. All these dev boards have an USB UART that is **always on**, even in deep sleep. And this eats a lot of energy. There is a really good post about why you should use ESP-12F over these devboards: https://github.com/z2amiller/sensorboard/blob/master/PowerSaving.md
Also: There is a reason why they are called **dev**boards ;) They are not really meant to be used "in production."

## Which kind of soil moisture sensors exist / should I use?
### 1. Electrical conduction sensors (Don't use: Boooo!)
When I was first playing with these soil moisture sensors, I've started with these sensors, which have a (visible) copper/some metal layer and two legs: They measure the soil moisture based on the electrical conduction of the soil / between the two legs.
The downside of these is that they can corrode and actually harm the plants, instead of surveiling them ;) And I don't know what upsides they actually have compared to:

### 2. Capacitive Soil Moisture Sensor (Use: Coooool!)
You guessed it: These sensors work by measuring the capacitance of the sensor (or it's layers (the electrodes)), where the soil and water function as the dielectric. These do not have copper layers being exposed which could corrode, so make them safe to use in any plant.
If you **really** want to deep dive into how these sensors work and how to properly calibrate them, lead this publication: https://www.researchgate.net/publication/342751186_Capacitive_Soil_Moisture_Sensor_Theory_Calibration_and_Testing

## How it looks
![How it looks](https://github.com/ezcGman/soil-moisture-sensor/blob/master/pictures/SoilMoistureSensor-PCB.jpg?raw=true)

## Example application with an ESP-07 / external antenna outside (waterproof)
*Yes, I know: This is currently an ESP-12F, because I'm waiting for the ESP-07 to arrive. But then this will be powered by an ESP-07 ;)*
I just used an old jelly glass, drilled two holes in it and sealed them with hot glue. Therefore it's perfectly waterproof :)
![How it looks](https://github.com/ezcGman/soil-moisture-sensor/blob/master/pictures/SoilMoistureSensor-Glass.jpg?raw=true)
![How it looks](https://github.com/ezcGman/soil-moisture-sensor/blob/master/pictures/SoilMoistureSensor-Outside.jpg?raw=true)

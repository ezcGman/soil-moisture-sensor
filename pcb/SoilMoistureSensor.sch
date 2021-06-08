EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:Battery_Cell BT1
U 1 1 60983485
P 4650 3900
F 0 "BT1" H 4768 3996 50  0000 L CNN
F 1 "3.2V" H 4768 3905 50  0000 L CNN
F 2 "Andys-Footprints:BatteryHolder_Keystone_2460_1xAA-removed-holes" V 4650 3960 50  0001 C CNN
F 3 "~" V 4650 3960 50  0001 C CNN
	1    4650 3900
	1    0    0    -1  
$EndComp
$Comp
L RF_Module:ESP-12E U1
U 1 1 60983955
P 6500 3900
F 0 "U1" H 6500 4881 50  0000 C CNN
F 1 "ESP-12E" H 6500 4790 50  0000 C CNN
F 2 "Andys-Footprints:ESP-12-Socket" H 6500 3900 50  0001 C CNN
F 3 "http://wiki.ai-thinker.com/_media/esp8266/esp8266_series_modules_user_manual_v1.1.pdf" H 6150 4000 50  0001 C CNN
	1    6500 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 609848F0
P 5400 2650
F 0 "R2" H 5470 2696 50  0000 L CNN
F 1 "220kΩ" H 5470 2605 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5330 2650 50  0001 C CNN
F 3 "~" H 5400 2650 50  0001 C CNN
	1    5400 2650
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R3
U 1 1 60984CF9
P 6000 2650
F 0 "R3" H 6070 2696 50  0000 L CNN
F 1 "100kΩ" H 6070 2605 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5930 2650 50  0001 C CNN
F 3 "~" H 6000 2650 50  0001 C CNN
	1    6000 2650
	0    -1   -1   0   
$EndComp
$Comp
L Device:C C2
U 1 1 60986418
P 5750 4050
F 0 "C2" H 5865 4096 50  0000 L CNN
F 1 "100nF" H 5865 4005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5788 3900 50  0001 C CNN
F 3 "~" H 5750 4050 50  0001 C CNN
	1    5750 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 609866EB
P 5500 3300
F 0 "C1" H 5615 3346 50  0000 L CNN
F 1 "10µF" H 5615 3255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 5538 3150 50  0001 C CNN
F 3 "~" H 5500 3300 50  0001 C CNN
	1    5500 3300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 6098A056
P 5200 4050
F 0 "R1" H 5270 4096 50  0000 L CNN
F 1 "10kΩ" H 5270 4005 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 5130 4050 50  0001 C CNN
F 3 "~" H 5200 4050 50  0001 C CNN
	1    5200 4050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 6098A5D2
P 7500 4450
F 0 "R4" H 7570 4496 50  0000 L CNN
F 1 "10kΩ" H 7570 4405 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 7430 4450 50  0001 C CNN
F 3 "~" H 7500 4450 50  0001 C CNN
	1    7500 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 4600 6500 4700
Wire Wire Line
	6500 4700 5750 4700
Connection ~ 5500 4700
Wire Wire Line
	4650 3500 4650 3100
Wire Wire Line
	5900 3300 5900 2850
Wire Wire Line
	5900 2850 7200 2850
Wire Wire Line
	4650 3100 4750 3100
Wire Wire Line
	5500 3150 5500 3100
Connection ~ 5500 3100
Wire Wire Line
	5500 3100 6500 3100
Wire Wire Line
	5500 3450 5500 4700
Wire Wire Line
	4650 3500 5200 3500
Wire Wire Line
	4650 4700 5200 4700
Wire Wire Line
	5200 3900 5200 3500
Connection ~ 5200 3500
Wire Wire Line
	5200 3500 5900 3500
Wire Wire Line
	5200 4200 5200 4700
Connection ~ 5200 4700
Wire Wire Line
	5200 4700 5500 4700
Wire Wire Line
	4750 2550 4750 3100
Wire Wire Line
	4850 2550 4850 2650
Wire Wire Line
	4850 2650 5250 2650
Wire Wire Line
	5550 2650 5750 2650
Wire Wire Line
	7300 2650 7300 4700
Wire Wire Line
	7300 4700 6500 4700
Connection ~ 6500 4700
Connection ~ 4750 3100
Wire Wire Line
	4750 3100 5500 3100
Wire Wire Line
	6150 2650 7300 2650
Wire Wire Line
	5900 3700 5750 3700
Wire Wire Line
	5750 3700 5750 2650
Connection ~ 5750 2650
Wire Wire Line
	5750 2650 5850 2650
Wire Wire Line
	7100 4300 7200 4300
Wire Wire Line
	7200 2850 7200 4300
Wire Wire Line
	7100 4200 7500 4200
Wire Wire Line
	7500 4200 7500 4300
Wire Wire Line
	7500 4600 7500 4700
Wire Wire Line
	7500 4700 7300 4700
Connection ~ 7300 4700
Wire Wire Line
	4650 4000 4650 4700
Wire Wire Line
	4650 2750 8000 2750
Wire Wire Line
	8000 2750 8000 3500
Wire Wire Line
	4650 2550 4650 2750
Wire Wire Line
	8000 3900 8000 4700
Wire Wire Line
	8000 4700 7500 4700
Connection ~ 7500 4700
Wire Wire Line
	5750 3700 5750 3900
Connection ~ 5750 3700
Wire Wire Line
	5750 4200 5750 4700
Connection ~ 5750 4700
Wire Wire Line
	5750 4700 5500 4700
Connection ~ 4650 3500
Wire Wire Line
	4650 3700 4650 3500
Text Label 4650 3600 0    50   ~ 0
+3.2V
Text Label 4650 4100 0    50   ~ 0
GND
$Comp
L Connector:Conn_01x03_Male J1
U 1 1 6098927A
P 4750 2350
F 0 "J1" H 4858 2631 50  0000 C CNN
F 1 "Conn_01x03_Male" H 4858 2540 50  0000 C CNN
F 2 "Andys-Footprints:PinHeader_1x03_P2.54mm_Vertical-Fixed-SilkScreen" H 4750 2350 50  0001 C CNN
F 3 "~" H 4750 2350 50  0001 C CNN
	1    4750 2350
	0    1    1    0   
$EndComp
$Comp
L Transistor_BJT:2N2219 Q1
U 1 1 6098828C
P 7900 3700
F 0 "Q1" H 8090 3746 50  0000 L CNN
F 1 "2N2222" H 8090 3655 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_HandSolder" H 8100 3625 50  0001 L CIN
F 3 "http://www.onsemi.com/pub_link/Collateral/2N2219-D.PDF" H 7900 3700 50  0001 L CNN
	1    7900 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 609843F5
P 7400 3700
F 0 "R5" H 7470 3746 50  0000 L CNN
F 1 "1kΩ" H 7470 3655 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" V 7330 3700 50  0001 C CNN
F 3 "~" H 7400 3700 50  0001 C CNN
	1    7400 3700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7700 3700 7550 3700
Wire Wire Line
	7250 3700 7100 3700
Text Label 8000 3150 0    50   ~ 0
SNSR-TRIG
Text Label 5750 2900 0    50   ~ 0
SIG-1V
Text Label 5100 2650 0    50   ~ 0
SIG-3V3
Text Label 7400 4200 0    50   ~ 0
ESP-BOOT
NoConn ~ 5900 3900
NoConn ~ 5900 4000
NoConn ~ 5900 4100
NoConn ~ 5900 4200
NoConn ~ 5900 4300
NoConn ~ 5900 4400
NoConn ~ 7100 4100
NoConn ~ 7100 4000
NoConn ~ 7100 3900
NoConn ~ 7100 3800
NoConn ~ 7100 3600
NoConn ~ 7100 3300
NoConn ~ 7100 3400
NoConn ~ 7100 3500
$EndSCHEMATC

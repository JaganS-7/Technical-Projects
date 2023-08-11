#include <dht.h>            // Include library
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#define outPin 8           // Defines pin number to which the sensor is connected

float calibration_value = 25.7 ;
unsigned long int avgval;
int buffer_arr[10],temp;

float ph_act;

dht DHT;            // Creates a DHT object

void setup() {
    Wire.begin();
    Serial.begin(9600);
    pinMode(outPin, OUTPUT);
    pinMode(13, OUTPUT);
    pinMode(12 , OUTPUT);
}

void loop() {
    digitalWrite(13, HIGH); // set pin 13 high
    // wait for 1 second
digitalWrite(12 , HIGH);
    int readData = DHT.read11(outPin);
    float t = DHT.temperature; // Read temperature
    float h = DHT.humidity;    // Read humidity
    Serial.print("Temperature = ");
    Serial.print(t);
    Serial.print("°C | ");
    Serial.print((t*9.0)/5.0+32.0);  // Convert celsius to fahrenheit
    Serial.println("°F ");
    Serial.print("Humidity = ");
    Serial.print(h);
    Serial.println("% ");
    Serial.println("");
 delay(5000);
      digitalWrite(13, LOW);      // set pin 13 low
 avgval=0;
 for(int i=2;i<8;i++){
    int temp = analogRead(A0);
    Serial.print(temp);
    Serial.print(" ");
    avgval+=temp;

     delay(30);
     // avgval+=buffer_arr[i];
}

 float volt=((float)avgval/6)*(5.0/1024);
 Serial.println("\nvoltl: ");
 Serial.println(volt);

Serial.println("pH Val: ");

float ph_act = ph(volt);
Serial.println(ph_act);

long DO ;
long T = t * t ;
DO = 8.3 * (14.62 - 0.4119*t + 0.008132*(T) - 0.0003125*(T*t)) ;
Serial.println("DO Val: ");
Serial.println(DO);
    delay(2000);      // wait two seconds
}

float ph (float voltage) {
    return ((voltage) / 5)*14;
}


//other information on dissolved oxygen
// float a = 0.287;
// float b = 3.319;
// float c = 1.53;
// float PSS = 0.0080 * sqrt((42.914*(4005*t / (t + 15)))) ;
// float Salinity = 1.80655 * PSS;

// float saturation_concentration = 14.62 - 0.3977 * t - 0.00058 * (pow(t, 2)) + (34.494 - 0.0176 * t) * (Salinity / 1000);
// long DO = a *saturation_concentration * (pow(10 , (b * ph_act - c)));
// Serial.println("Salinity : ");
// Serial.println(Salinity);
// Serial.println("saturation concentration: ");
// Serial.println(saturation_concentration);

/*The calculation of dissolved oxygen (DO) in water is influenced by several factors, including temperature, pressure, salinity, and  atmospheric conditions. 
The atmospheric conditions that affect DO are mainly the atmospheric pressure, temperature, and relative humidity. 
The pH of water also plays a role in DO levels, but it is not directly related to the atmospheric conditions./*

// To calculate the DO level in water based on the atmospheric conditions, you can use the following formula:
// DO (mg/L) = [Atm. Pressure (mmHg) / 760] * [Oxygen Saturation at Water Temp. (mg/L)] * [Percent Saturation at Atmospheric Conditions]
// where:
// Atm. Pressure: the atmospheric pressure in millimeters of mercury (mmHg) at the location where the water sample was taken
// Oxygen Saturation at Water Temp.: the maximum amount of dissolved oxygen that water can hold at a given temperature (mg/L). 
This value can be obtained from a dissolved oxygen table or calculator.

// Percent Saturation at Atmospheric Conditions: the percentage of dissolved oxygen saturation in water at the given atmospheric conditions.
This value can also be obtained from a dissolved oxygen table or calculator that takes into account the temperature, pressure, and relative humidity of the atmosphere.

// The pH of water can also affect the DO level, as water with a higher pH tends to have a lower DO level. However, the effect of pH on DO is
relatively small compared to the effect of temperature, pressure, and atmospheric conditions. To calculate the effect of pH on DO, you can use
the following formula:
// DO (mg/L) = DO at pH 7.0 (mg/L) * 10^(pH-7)
// DO at pH 7.0: the dissolved oxygen level at pH 7.0, which is typically around 8-9 mg/L at standard conditions.

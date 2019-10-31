#include <SoftwareSerial.h>

SoftwareSerial hc06(2,3);


//  /dev/cu.DanHC01-DevB'
void setup(){
  //Initialize Serial Monitor
  Serial.begin(9600);
  Serial.println("ENTER AT Commands:");
  //Initialize Bluetooth Serial PortS
  hc06.begin(9600);
}

void loop(){
  //Write data from HC06 to Serial Monitor
  while (hc06.available()){
    Serial.write(hc06.read());
  }
  
  //Write from Serial Monitor to HC06
  while (Serial.available()){
    hc06.write(Serial.read());
  }  
}

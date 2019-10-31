#include <attiny85_ir_send.h>

// defining pins
const int buttonPin =  4 ; //button connected to attiny physical pin 3 and ground 
const int ledPin   =  0 ;     // (optional)attiny physical pin 5 , normal led for visual feedback of when we are sending an ir command. 
                          //Use at least a 470R resistor in series with it
int buttonState = 0;
//change 00000 to a NEC code!
//#define YOUR_NEC_CODE 0xFF6897
//#define YOUR_NEC_CODE 0x111111
//#define YOUR_NEC_CODE 16738455


IRsend irsend; // IR led on physical pin 6 (Digital 1) , the IR output will be always on attiny physical pin 6

void setup() {
  pinMode(buttonPin, INPUT);
  pinMode(ledPin,OUTPUT);
  digitalWrite(ledPin,LOW);
}

void loop() {
  buttonState = digitalRead(buttonPin);

  if(buttonState == HIGH){
    digitalWrite(ledPin, HIGH);

   irsend.sendNEC(0xFF6897, 32);
    delay(400);

  }

  else if(buttonState ==LOW){
      
        digitalWrite(ledPin, LOW);
  }
  
 }

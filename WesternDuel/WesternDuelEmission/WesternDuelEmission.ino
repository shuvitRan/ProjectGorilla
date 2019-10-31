#include <IRremote.h>

//pwm pin9 at nano pin three for other
IRsend irsend;

const int buttonPin =5;
const int soundPin =7;
const int ledPin = 13;
int buttonState = 0;



void setup()
{
   pinMode(soundPin,OUTPUT);
  pinMode(ledPin,OUTPUT);
  pinMode(buttonPin,INPUT);
  Serial.begin(9600);
}

void loop() {
buttonState = digitalRead(buttonPin);
  if(buttonState == HIGH){
    digitalWrite(ledPin, HIGH);
   tone(soundPin, 1000);
//NEC ir 0xFF6897  =0  32bit
//  irsend.sendNEC(0xFF6897, 32);
//NEC Ir FF30cf = 2;
irsend.sendNEC(0xFF30CF, 32);

  
    delay(400);
    noTone(soundPin); 
    } else if(buttonState ==LOW){
      
        digitalWrite(ledPin, LOW);
  }
//    delay(1000);
 
  
}

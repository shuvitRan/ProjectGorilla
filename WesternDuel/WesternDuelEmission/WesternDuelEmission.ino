#include <IRremote.h>

IRsend irsend;

const int buttonPin =4;
const int ledPin = 13;
int buttonState = 0;



void setup()
{
  pinMode(ledPin,OUTPUT);
  pinMode(buttonPin,INPUT);
  
}

void loop() {
buttonState = digitalRead(buttonPin);
  if(buttonState == HIGH){
    digitalWrite(ledPin, HIGH);
  for (int i = 0; i < 3; i++) {
    irsend.sendSony(0xa90, 12);
    delay(40);
    }
    delay(1000);
  }
  
}

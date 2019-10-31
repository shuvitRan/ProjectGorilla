#include <IRremote.h>

IRsend irsend;

const int buttonPin =4;
const int buttonPin2 = 8;

const int soundPin =2;


const int ledPin = 13;
int buttonState = 0;

int buttonState2= 0;





void setup()
{
  pinMode(soundPin,OUTPUT);
  pinMode(ledPin,OUTPUT);
  pinMode(buttonPin,INPUT);
    pinMode(buttonPin2,INPUT);
  Serial.begin(9600);
}

void loop() {

  
buttonState = digitalRead(buttonPin);

buttonState2 = digitalRead(buttonPin2);

//Serial.println(buttonState2);

  if(buttonState == HIGH){
    digitalWrite(ledPin, HIGH);

    
     tone(soundPin, 1000);
//NEC ir 0xFF6897  =0  32bit
  irsend.sendNEC(0xFF6897, 32);
    delay(400);

  // Send 1KHz sound signal...      // ...for 1 sec
  noTone(soundPin);     // Stop sound...
//  delay(400);  

//1
//  irsend.sendNEC(0xFF30CF, 32);
//    delay(1000);

   } else if(buttonState ==LOW){
      
        digitalWrite(ledPin, LOW);
  }

  if(buttonState2 == HIGH){
    digitalWrite(ledPin, HIGH);
    tone(soundPin, 1000);
//NEC ir 0xFF6897  =0  32bit
//  irsend.sendNEC(0xFF6897, 32);
//    delay(1000);

//1
  irsend.sendNEC(0xFF30CF, 32);
    delay(400);

     noTone(soundPin);     // Stop sound...
//  delay(400);  

   } else if(buttonState2 ==LOW){
      
        digitalWrite(ledPin, LOW);
  }

  
  
}

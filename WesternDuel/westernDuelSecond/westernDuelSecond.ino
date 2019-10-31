#include <IRremote.h>

//const int buttonPin = 2;
//const int ledPin = 13;


//Receiver
const int RECV_PIN = 7;
IRrecv irrecv(RECV_PIN);
decode_results results;

//int number = 0;


void setup(){

  Serial.begin(9600);
  irrecv.enableIRIn();
 

}

void loop(){

   if (irrecv.decode(&results)){
//        Serial.println("Second Heart");
//        Serial.println(results.value, HEX);
//        Serial.println(results.value+5);
//        Serial.println(results.value);
     if(results.value == 16724175) {
        Serial.println(2);
        irrecv.blink13(true);
      }else{
        irrecv.blink13(false);
      }
        
        irrecv.resume();
                           

        
    }


}



  

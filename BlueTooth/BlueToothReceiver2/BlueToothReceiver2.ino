#include <IRremote.h>
#include <SoftwareSerial.h>

SoftwareSerial hc06(2,3);
String cmd="";



//led parts
#include "FastLED.h"            // 此示例程序需要使用FastLED库
#define NUM_LEDS 13             // LED灯珠数量
#define LED_DT 5                // Arduino输出控制信号引脚
#define LED_TYPE WS2812         // LED灯带型号
#define COLOR_ORDER GRB        // RGB灯珠中红色、绿色、蓝色LED的排列顺序
uint8_t max_bright = 128;       // LED亮度控制变量，可使用数值为 0 ～ 255， 数值越大则光带亮度越高
CRGB leds[NUM_LEDS];      

//const int buttonPin = 2;
//const int ledPin = 13;


//Receiver
const int RECV_PIN = 7;
IRrecv irrecv(RECV_PIN);
decode_results results;



void setup(){

    //led
  LEDS.addLeds<LED_TYPE, LED_DT, COLOR_ORDER>(leds, NUM_LEDS);  // 初始化光带  
  FastLED.setBrightness(max_bright);  


  Serial.begin(9600);
  irrecv.enableIRIn();

   delay(50);
   hc06.begin(9600);
 
}

void loop(){


   if (hc06.available())
  // if text arrived in from BT serial...
  {
    cmd=(hc06.read());
    if (cmd=="1")
    {
      //digitalWrite(ledPin, HIGH);
//      hc06.println("LED on");

  fill_gradient(leds, 0, CHSV(255, 255,255) , 12, CHSV(255,255,255), LONGEST_HUES);
//fill_gradient_RGB(leds, 0, CRGB(255, 50,50) , 12, CRGB(255,80,25), LONGEST_HUES);
  FastLED.show();


    }else if(cmd=="0"){
      
       fill_gradient(leds, 0, CHSV(55, 50,155) , 12, CHSV(95,255,255), LONGEST_HUES);
//       fill_gradient_RGB(leds, 0, CRGB(55, 255,30) , 12, CRGB(125,255,100),LONGEST_HUES);
        FastLED.show();
      }
  }
  

   if (irrecv.decode(&results)){
//        Serial.println("Second Heart");
//        Serial.println(results.value, HEX);
//        Serial.println(results.value+5);
//        Serial.println(results.value);
     if(results.value == 16724175)  {
        Serial.println(2);
         irrecv.blink13(true);
         hc06.println(2);
         
      }else{
        irrecv.blink13(false);
      }
        
        irrecv.resume();


    }

    delay(100);



}

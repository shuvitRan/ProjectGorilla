/*
 * fillGradient
 * 太极创客 http://www.taichi-maker.com/
 * 03/01/2018
 * 
 * =====================功能说明=====================
 * 使用Arduino Uno开发板通过FastLED库控制WS2812光带。
 * fillGradient库函数使用说明。 
 * 
 * 本示例程序需要Arduino第三方库FastLED。如有需要，可通过以下链接下载该库:
 * http://www.taichi-maker.com/homepage/download/#library-download
 * 
 * 如需了解如何为Arduino IDE安装第三方库，请参见以下链接地址的视频教程：
 * http://www.taichi-maker.com/homepage/reference-index/arduino-library-index/install-arduino-library/
 *  
 * =====================电路连接======================
 * 此示例程序中，Arduino输出控制信号引脚为9号引脚。
 * 
 * 如需获得详细电路连接说明图，请参阅太极创客网站中
 * 有关WS2812 LED光带方面的相关内容，太极创客网站地址：
 * 
 *  http://WWW.TAICHI-MAKER.COM
 * 
 * 此示例程序为配合太极创客制作的
 * 《零基础入门学用ARDUINO教程-智能应用篇》使用
 */
#include "FastLED.h"            // 此示例程序需要使用FastLED库
 
#define NUM_LEDS 13             // LED灯珠数量
#define LED_DT 5                // Arduino输出控制信号引脚
#define LED_TYPE WS2812         // LED灯带型号
#define COLOR_ORDER GRB         // RGB灯珠中红色、绿色、蓝色LED的排列顺序
 
uint8_t max_bright = 128;       // LED亮度控制变量，可使用数值为 0 ～ 255， 数值越大则光带亮度越高
 
CRGB leds[NUM_LEDS];            // 建立光带leds
 
void setup() { 
  LEDS.addLeds<LED_TYPE, LED_DT, COLOR_ORDER>(leds, NUM_LEDS);  // 初始化光带  
  FastLED.setBrightness(max_bright);                            // 设置光带亮度
}
 
void loop () {       
  // fill_gradient 显示两种颜色  
  //fill_gradient(leds, 0, CHSV(50, 255,255) , 29, CHSV(150,255,255), SHORTEST_HUES);
  fill_gradient(leds, 0, CHSV(55, 50,155) , 12, CHSV(125,255,255), LONGEST_HUES);
  FastLED.show();
  delay(50);
} 
 

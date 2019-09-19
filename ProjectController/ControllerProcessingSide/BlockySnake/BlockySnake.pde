import processing.serial.*;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import processing.sound.*;

String[] soundLink ={"assets/right.wav","assets/wrong.wav"};
SoundFile[] soundfile = new SoundFile[soundLink.length];

Serial myPort;
Robot robot;
//int[] sensor = {0, 0};
String sensorValue = "1";
boolean startKeyboard = false; 
boolean startKeyboard2 = false; 

void setup() {
  
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[6], 9600);
  myPort.bufferUntil ('\n');
  try {
    robot = new Robot(); 
  }
  catch (AWTException e) {
    e.printStackTrace();
    exit();
  }
  
     for (int i =0 ; i<soundLink.length; i++){
  
  soundfile[i] = new SoundFile(this, soundLink[i]);
  
   }
  
  
  
}

void draw() {
  

  if(startKeyboard){
     if(sensorValue.equals("UP")){
     //println("enter");
     robot.keyPress(KeyEvent.VK_ENTER);
     robot.delay(100);
     robot.keyRelease(KeyEvent.VK_ENTER);
     sensorValue = "stop" ;
    }
     if(sensorValue.equals("DOWN")){
     //println("exit");
     robot.keyPress(KeyEvent.VK_ESCAPE);
     robot.delay(100);
     robot.keyRelease(KeyEvent.VK_ESCAPE);
     sensorValue = "stop" ;
    }
     if(sensorValue.equals("LEFT")){
     //println("left");
     robot.keyPress(KeyEvent.VK_LEFT);
     robot.delay(100);
     robot.keyRelease(KeyEvent.VK_LEFT);
     sensorValue = "stop" ;
     soundfile[0].play();
    }
     if(sensorValue.equals("RIGHT")){
     //println("right");
     robot.keyPress(KeyEvent.VK_RIGHT);
     robot.delay(100);
     robot.keyRelease(KeyEvent.VK_RIGHT);
     sensorValue = "stop" ;
     soundfile[0].play();
    }
      if(sensorValue.equals("NONE")){
     //println("wrong");
     sensorValue = "stop" ;
     soundfile[1].play();
    }
  }
  
  
  if(startKeyboard2){
     if(sensorValue.equals("UP")){
       soundfile[0].play();
       robot.keyPress(KeyEvent.VK_UP);
       robot.delay(100);
       robot.keyRelease(KeyEvent.VK_UP);
       sensorValue = "stop" ;
    }
     if(sensorValue.equals("DOWN")){
       soundfile[0].play();
       robot.keyPress(KeyEvent.VK_DOWN);
       robot.delay(100);
       robot.keyRelease(KeyEvent.VK_DOWN);
       sensorValue = "stop" ;
    }
     if(sensorValue.equals("LEFT")){
         soundfile[0].play();
         //println("left");
         robot.keyPress(KeyEvent.VK_LEFT);
         robot.delay(100);
         robot.keyRelease(KeyEvent.VK_LEFT);
         sensorValue = "stop" ;
    }
     if(sensorValue.equals("RIGHT")){
     soundfile[0].play();
     robot.keyPress(KeyEvent.VK_RIGHT);
     robot.delay(100);
     robot.keyRelease(KeyEvent.VK_RIGHT);
     sensorValue = "stop" ;
    }
    if(sensorValue.equals("NONE")){
     sensorValue = "stop" ;
     soundfile[1].play();
    }
    
  
  
  
  }
  
  
  
  //println(sensorValue);

  //if (sensor[0] == 0) {  
  //  robot.keyPress(KeyEvent.VK_A);
  //  robot.delay(100);
  //  robot.keyRelease(KeyEvent.VK_A);
  //}
  //if (sensor[1] == 0 ){
  //   robot.keyPress(KeyEvent.VK_G);
  //   robot.delay(100);
  //   robot.keyRelease(KeyEvent.VK_G);
     
  //}
}


void keyReleased() {

    if(key == 'k'){
    startKeyboard =!startKeyboard;
    }
     if(key == 'j'){
    startKeyboard2 =!startKeyboard2;
    }
    println("Blocky Snake:"+startKeyboard);
    println("2048:"+startKeyboard2);
  }


void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  inString = trim(inString);
  //println(inString);
   
  if (inString != null) {
  //  String[] parsedSerial = split(inString, ',');
  //  for (int x = 0; x < 2; x=x+1) {
  //    sensor[x] = parseInt(parsedSerial[x]);
  sensorValue = inString;
  //  
  
  } else{
  sensorValue = "whoops";
  }
}

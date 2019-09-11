import processing.serial.*;
import processing.sound.*;

Serial myPort;

SoundFile soundfile;

int lf = 10;
String serialString = null;
int analogSensorData = 0;
float positionX = 100;

void setup(){

size (800, 600);
printArray(Serial.list());
 
myPort = new Serial(this, Serial.list()[9],9600);

myPort.clear();

serialString = myPort.readStringUntil(lf);

serialString = null;
 

soundfile = new SoundFile(this, "assets/GorillaSound.mp3");


//soundfile.loop();
}



void draw()  {

background(0);

  if ( myPort.available()>0){
    serialString = myPort.readStringUntil(lf);
    if (serialString != null) {
    serialString = serialString.trim(); //get rid of [CR] and extra space
    ////if there is more than one input
    //String[] sensorDataString = split(serialString, ";");
    
    analogSensorData = int(serialString); 
   
    
    positionX = map(analogSensorData, 0, 250, 100, width-100);
    //println("PressureSensor reading = " + analogSensorData); 
    
    
    float amplitude = map(analogSensorData, 100, 250, 0.2,1.0); 
    println(amplitude);
    soundfile.amp(amplitude);
    if(analogSensorData >= 100 && !soundfile.isPlaying()){
    soundfile.play();     
    } else if(analogSensorData >= 100 && soundfile.isPlaying()){
     //soundfile.play();  
     return;
    } else if (analogSensorData<100 && !soundfile.isPlaying()){
     return;
      
    }
    
    

    }
      
  } 

  ellipse(positionX, height/2, 150, 150);

}


void soundfile(){




}

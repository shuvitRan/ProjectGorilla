import processing.serial.*;
import processing.sound.*;

Serial myPort;
String[] soundLink ={"assets/GorillaSound.mp3","assets/ApeSound.mp3", "assets/gibbon-monkey.mp3"};
SoundFile[] soundfile = new SoundFile[soundLink.length];

WildAnimal wildAnimal;

PImage gorillaImg;

boolean poundChest = false, prePoundChest = false, udead=false;

int lf = 10;
String serialString = null;
int analogSensorData = 0;
float ellipseScale = 100;
int soundPlay;
int score;
int count = 3000;
int timer;
boolean timeBool=false;


void setup(){

size (1600, 1000);
printArray(Serial.list());
 
myPort = new Serial(this, Serial.list()[9],9600);

myPort.clear();

serialString = myPort.readStringUntil(lf);

serialString = null;
 
   for (int i =0 ; i<soundLink.length; i++){
  
  soundfile[i] = new SoundFile(this, soundLink[i]);
  
   }
//soundfile[0].loop();

//printArray(soundfile);
soundPlay = int(random(soundfile.length));

gorillaImg = loadImage("assets/Gorilla.png");

//PVector animalLocation = new PVector (20,0); 

wildAnimal= new WildAnimal(10);



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
  
    ellipseScale = map(analogSensorData, 0, 250, 100, 400);
    
     if(dist(wildAnimal.mylocation.x,wildAnimal.mylocation.y,width/2,height/2)<=30){
      fill(255,0,0);
      udead = true;     
      //randomLocation();
      }else {
      fill(255);
    
       gorillaSound();
      }
  
  
    
    //println("PressureSensor reading = " + analogSensorData); 

    }
      
  } 
  text(score, 10, 30); 
  timer= millis();
  if(udead==true ){
    
    if(udead!= timeBool && timeBool==false){
      count=timer;
    }
    if(timer-count>=3000 && analogSensorData > 30){
    
      wildAnimal.randomLocation();
      udead=false;
       score = 0;
    }
    
    textSize(30);
    text("Whoops try again.", width/2, height*2/3); 
    timeBool=udead;
  }
  
  
  //println(timer-count);
  ellipse(width/2, height/2,  ellipseScale, ellipseScale);
  imageMode(CENTER);
  image( gorillaImg, width/2, height/2,ellipseScale,ellipseScale );
  
  
  wildAnimal.update();
}


void gorillaSound(){

   float amplitude = map(analogSensorData, 30, 220, 0.2,1.0); 
    //println(soundPlay);
    
    soundfile[soundPlay].amp(amplitude);
    
    if(analogSensorData > 30 ){
      //prePoundChest= false;
      poundChest =true; 
      
      if(poundChest !=prePoundChest && prePoundChest ==false ){
         
        
          if(!soundfile[soundPlay].isPlaying()){
            soundfile[soundPlay].play(); 
            soundPlay = int(random(soundfile.length));
          }
        
         wildAnimal.randomLocation();
         score ++; 
      }
      
      //prePoundChest = poundChest;

    }else if(analogSensorData < 30) {
      
      poundChest=false;
    
    }
     prePoundChest=poundChest;


}


//import ddf.minim.analysis.*;
//import ddf.minim.effects.*;
//import ddf.minim.signals.*;
//import ddf.minim.spi.*;
//import ddf.minim.ugens.*;
import processing.sound.*;
import processing.serial.*;
//import cc.arduino.*;

//Arduino arduinoOne;
//Arduino arduinoTwo;

Serial port1;
Serial port2;

int interval = 0;

int lf = 10;

String serialOneRead = null;
String serialTwoRead = null;

int serialOneNumber = 0;
int serialTwoNumber = 0;

int finalCase =0;


SoundFile bgMusic;
SoundFile CountDown;
SoundFile ResultBGM;
SoundFile DuelBGM;
SoundFile pistalSound;
SoundFile deadS1;
SoundFile deadS2;
SoundFile outlawS;
SoundFile buntyS;


String state= "Start";
String result = "No Result";
int gameTimer, sec, countDown=6, gameCountDown=11 ;
boolean button = false;
boolean timeControl = false, gameControl = false;

boolean readytoShot = false, resultReady = false;;

boolean playerOne= false , playerTwo = false;

PFont TitleFont, subFont;
float fadevalue = 0.0;
int MAX = 255;
float textFadeSpeed= 2.0;


//sands
ParticleSystem sands = new ParticleSystem();
boolean mouseDown = false;

void setup(){
  
   smooth();
  noStroke();
   ellipseMode(RADIUS);
  TitleFont = createFont("CarnevaleeFreakshow.ttf", 100, true);
  subFont = createFont("SubwayNovella.ttf", 150,true);
  printArray(Serial.list());
  
  bgMusic = new SoundFile(this, "Music/finalDuel.mp3");
  CountDown = new SoundFile(this, "Music/CountDownFrom5.aif");
   ResultBGM = new SoundFile(this, "Music/Result.mp3");
   DuelBGM = new SoundFile(this, "Music/Duel.mp3");
    pistalSound = new SoundFile(this, "Music/pistal.wav");
    deadS1 = new SoundFile(this, "Music/dead1.wav");
   deadS2 = new SoundFile(this, "Music/dead2.WAV");
  outlawS = new SoundFile(this, "Music/outlawdead.aif");
  buntyS = new SoundFile(this, "Music/buntyhunterdead.aif");
    

  
  // for wireless
  //port1 = new Serial(this, "/dev/cu.WEST01-DevB", 9600);
  //port2 = new Serial(this, "/dev/cu.WEST02-DevB", 9600);
  //port1.clear();
  //port2.clear();
  
  
  //port1.bufferUntil(lf);
  //port2.bufferUntil(lf);
  
  //serialOneRead = port1.readStringUntil(lf);
  //serialOneRead = null;
  
  //serialTwoRead = port2.readStringUntil(lf);
  //serialTwoRead = null;
  
  delay(100);

  surface.setSize(1280,720);
  surface.setResizable(true);

  //fullScreen();
  sec=millis();
  
  bgMusic.loop();

}


void draw(){
  
  if(keyPressed && key ==ENTER){
   button = true;
  } else {
  
  button = false;
  
  }
  //println(serialOneRead);
  switch (state){
  
  case "Start":
  if(DuelBGM.isPlaying()){
  DuelBGM.stop();
  }
  
  //port1.write(0);
  //  port2.write(0);
  
    finalCase =0;
    StartScene();
     translate(-0.5 * width+300, -0.5 *height);
    sands.add(new Particle(random(width), 0));
    sands.run();
    //println(sands.particles.size());
    break;
    
  case "CountStart":
      
      fadevalue=0;
      //port1.clear();
      //port2.clear();
      readytoShot= false;
      timeControl = true;
    if(timeControl==true){
      Timer();
      background(236, 73, 19);
      translate(0.5 * width, 0.5 *height);
      fill(0);
      textFont(subFont, 150);  
      textAlign(CENTER);
      text(countDown, 0, 50);
   
    }
   
       if(countDown == 0){
      
      DuelBGM.loop();
     gameCountDown= 11;
      delay(500);
      //port1.clear();
      //port2.clear();
      resultReady =false;
      state="GameStart";
      
   }
     
    //println(playerOne);
    //println(playerTwo);
  
    
    
    break;
    case "GameStart":
    
         //if(gameControl ==true && timeControl ==false){
         //serialOneRead = "0";
         // serialTwoRead = "0";
       if(millis()-sec>=1000 && gameCountDown>0){
          background(250, 73, 19);
          translate(0.5 * width, 0.5 *height);
           fill(0);
           textAlign(CENTER);
           readytoShot= true;
            textFont(subFont, 150); 
            text("DUEL", 0, 0);
           textFont(subFont, 50); 
             text("Time Remain "+gameCountDown+ " Sec", 0, 80);
             if(resultReady ==false){
            gameCountDown--;
            
           sec=millis();
             }
            //GameStart();
            GameStartForKey();

           
     
     }
     
   
     //println("One"+playerOne+" Two "+playerTwo);
     if(gameCountDown==0){    
       finalCase =1;
       result = "\u201C I Don't Wanna Shoot You, Partner.\" ";
       sec=millis();
       state =  "GameResult";
     } else if (playerOne==true && millis()-sec>=3000){
       deadS1.play();  
       finalCase =2;
       result = "The Outlaw is Killed";
       sec=millis();
        DuelBGM.stop();
       ResultBGM.play();
       delay(500);
       outlawS.play();
       //port1.write(1);
       state =  "GameResult";
     } else if  (playerTwo==true && millis()-sec>=3000){
        deadS2.play();
       finalCase =3;
      result = "The Bounty Hunter is Killed";
      sec=millis();
      DuelBGM.stop();
      ResultBGM.play();
       delay(500);
       buntyS.play();
       //port2.write(1);
      state =  "GameResult";
     }
     

    
    break;
    
   case "GameResult":
   
   
   if(millis()-sec<=10000){
     gameCountDown = 10;
     countDown = 6;
     playerOne = false;
     playerTwo = false;
     
     
     if(finalCase ==1){
    
     background(100, 73, 255);
     translate(0.5 * width, 0.5 *height);
     fill(0);
     textAlign(CENTER);
     textFont(subFont, 30);  
     text("No One is Hurt", 0, 80);
     textFont(subFont, 80);  
     text(result, 0, 0);
     
     } else if(finalCase ==2){
     
     background(50, 30, 20);
     translate(0.5 * width, 0.5 *height);
     fill(255,0,0);
     textAlign(CENTER);
     textFont(subFont, 100);
     text(result, 0, 30);
     
     } else if(finalCase ==3){
     
     
     background(180, 0, 0);
     translate(0.5 * width, 0.5 *height);
     fill(0);
     textAlign(CENTER);
     textFont(subFont, 100);
     text(result, 0, 30);
     
     
     }
     
     

   }
     else{
    
     state= "Start";
    bgMusic.loop();
   }

   break;
  
 }


}


void StartScene(){ 
       //port1.clear();
       //port2.clear();
       timeControl = false;
       
       background(255, 204, 0);
       translate(0.5 * width, 0.5 *height);
       fill(0);
       textFont(TitleFont, 120);
       textAlign(CENTER);
       text("Once Upon a Time at 16th St", 0, 0);
       textFont(subFont, 40);  
       fadevalue+=textFadeSpeed;
       float fade = ((sin(radians(fadevalue))+1)/2)*MAX;
       fill(0,fade);
       text("Push a button to Start the count down of the DUEL", 0, 80);
       
      if(state == "Start" && button == true){
        sands.removeAll();
      state ="CountStart";
      bgMusic.stop();
      CountDown.play();
      
      
  }

}


void Timer(){

  if(millis()-sec >= 1000 && timeControl == true){
    if(countDown>0){  
    countDown--;    
    sec = millis();
    } else if(timeControl == false || state == "Start"){
      
      countDown =6;
    
    }
  }
}





//void serialEvent(Serial thisPort){
//interval = millis();


//if( thisPort == port1){
//    if (port1.available()>0) {
  
      
      
//      serialOneRead = port1.readString();
//      //serialOneRead = port1.read();
  
      
//    } else{
//      serialOneRead = null;
//    }
//  }
 
//   if(thisPort == port2){
     
//    if (port2.available()>0) {
//      serialTwoRead = port2.readString();
//         //serialOneRead = port2.read();
      
//    } else{
    
//    serialTwoRead = null; 
    
//    }
//   }
  
// }

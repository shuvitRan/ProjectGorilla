

void GameStart(){

  if ( port1.available()>0 && readytoShot ==true){
    serialOneRead = port1.readStringUntil(lf);
    if (serialOneRead != null) {
     pistalSound.play();
     
      serialOneRead=serialOneRead.trim();
      serialOneNumber = int(serialOneRead);
       //println(serialOneRead.trim());
      if(serialOneNumber == 1 && resultReady == false){
       resultReady = true;
      
      println("player one win");
      playerOne= true;
      playerTwo = false;
      }
    }
  

} else{
  port1.clear();
  } 
  
  if ( port2.available()>0 && readytoShot ==true){
    serialTwoRead = port2.readStringUntil(lf);
    if (serialTwoRead != null) {
     pistalSound.play();
     serialTwoRead= serialTwoRead.trim();
      serialTwoNumber = int(serialTwoRead);
      if(serialTwoNumber == 2 && resultReady == false){
        resultReady = true;
       
      println("player two win");
        playerOne= false;
        playerTwo = true;
      } else{
        port1.clear();
      }
     
    }
}
};

void GameStartForKey(){
 if ( readytoShot ==true){
   if(key == 'b'){
      pistalSound.play();
     if(resultReady == false){
      resultReady = true;
        playerOne= false;
        playerTwo = true;}
   }
   
      if(key == 'o'){
         pistalSound.play();
          if(resultReady == false){
      resultReady = true;
        playerOne= true;
        playerTwo = false;
          }
   }

 }
}

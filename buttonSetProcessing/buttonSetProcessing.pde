import processing.serial.*;

Serial myPort;  // Create object from Serial class
int lf = 10;    // Linefeed in ASCII
String serialString = null;
int analogSensorData = 0;
float positionX = 100;

void setup(){

size(800, 600);

printArray(Serial.list());

myPort = new Serial(this, Serial.list()[9],9600);

myPort.clear();

serialString = myPort.readStringUntil(lf);

serialString = null;
  
}


void draw(){

  background(0);
  //reading available data from the serial port 
  if ( myPort.available() > 0) {
    //read serial data until Line Feed 
    serialString = myPort.readStringUntil(lf);
    
    //check if there is usable data
    if (serialString != null) {
      serialString = serialString.trim(); //get rid of [CR] and extra space
      String[] sensorDataString = split(serialString, ";");
      
      println(serialString);
      
      //if (sensorDataString.length == 2) { // make sure there are enough data 
        
        //check pushbutton - toggle between 2 color
        if(sensorDataString[0].equals("1")){
          fill(230,5,108);
        }else{                                      
          fill(125,175,44);
        }
        println("pushbutton reading = " + sensorDataString[0]);
        
        //check pot - move a circle horizontally
        analogSensorData = int(sensorDataString[1]);
        positionX = map(analogSensorData, 0, 1023, 100, width-100);
        println("pot reading = " + sensorDataString[1]); 
      //}
    }
  }
  
  ellipse(positionX, height/2, 150, 150);



}
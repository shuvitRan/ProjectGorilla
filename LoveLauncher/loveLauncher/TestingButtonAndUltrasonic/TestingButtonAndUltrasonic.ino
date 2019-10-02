
// constants won't change. They're used here to set pin numbers:
const int buttonPin = 4;     // the number of the pushbutton pin
const int ledPin =  13;      // the number of the LED pin

// variables will change:
int buttonState = 0;         // variable for reading the pushbutton status


//For ultrasonic sensor
const int trigPin = 6;
const int echoPin = 5;
long duration;
int distance;


//store message

float myMessage[5];

void setup() {
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin, INPUT);

    pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
Serial.begin(115200);
  
}

void loop() {
  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);

  // check if the pushbutton is pressed. If it is, the buttonState is HIGH:
  if (buttonState == HIGH) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
    myMessage[0] = buttonState;
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
    myMessage[0] = buttonState;
  }

// Clears the trigPin
digitalWrite(trigPin, LOW);
delayMicroseconds(2);
// Sets the trigPin on HIGH state for 10 micro seconds
digitalWrite(trigPin, HIGH);
delayMicroseconds(10);
digitalWrite(trigPin, LOW);
// Reads the echoPin, returns the sound wave travel time in microseconds
duration = pulseIn(echoPin, HIGH);
// Calculating the distance
distance= duration*0.034/2;
// Prints the distance on the Serial Monitor
//Serial.print("Distance: ");
//Serial.println(distance);
myMessage[1]=distance; 


Serial.println(distance);

//for(int i = 0; i < 6; i++)
//{
////  Serial.print(myMessage[i]);
////  Serial.print(",");
////}
////Serial.println(myMessage);
//Serial.println("End");

}

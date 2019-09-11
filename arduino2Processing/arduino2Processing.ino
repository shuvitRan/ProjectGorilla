/*
  DigitalReadSerial

  Reads a digital input on pin 2, prints the result to the Serial Monitor

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/DigitalReadSerial
*/

// digital pin 2 has a pushbutton attached to it. Give it a name:
const int pushButton = 2; // Digital input pin that the pushbutton is attached to
const int pot = A0;       // Analog input pin that the potentiometer is attached to

int state = 0;            // store value read from the the pushbutton
int sensorValue = 0;      // store value read from the potentiometer

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  // make the pushbutton's pin an input:
  pinMode(pushButton, INPUT);
  // [Very Important!] Enable internal pull-ups
  digitalWrite(pushButton, HIGH);
  delay(200);
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input pin:
  state = digitalRead(pushButton);
  sensorValue = analogRead(pot);
  // print out the state of the button:
  Serial.print(state);
  Serial.print(";");
  Serial.println(sensorValue);    //end of data
  delay(100);                      //delay in between reads for stability
}

int Led = 13 ;// define LED Interface
int buttonpin = 8; // define the obstacle avoidance sensor interface
int val ;// define numeric variables val
int val2;
int sharp =A1;
void setup ()
{
  pinMode (Led, OUTPUT) ;// define LED as output interface
  pinMode (buttonpin, INPUT) ;// define the obstacle avoidance sensor output interface
  Serial.begin(115200);
}
void loop ()
{
  val = digitalRead (buttonpin) ;// digital interface will be assigned a value of 3 to read val
  if (val == HIGH) // When the obstacle avoidance sensor detects a signal, LED flashes
  {
    digitalWrite (Led, HIGH);
  }
  else
  {
    digitalWrite (Led, LOW);
  }
//  Serial.println(val);

  val2 = analogRead(sharp);
  Serial.println(val2);


  
}

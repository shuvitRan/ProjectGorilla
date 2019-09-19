const int analogIn = A0;

int sensorValue = 0;

void setup() {

  Serial.begin(9600);

  delay(200);
  

}

void loop() {
  sensorValue = analogRead(analogIn);
  Serial.println(sensorValue);
  delay(100);
  

}

void setup() {
pinMode(13, OUTPUT);
}

void loop() {
  digitalWrite(13,HIGH);
  delay(700);
  digitalWrite(13, LOW);
  delay(700);
}

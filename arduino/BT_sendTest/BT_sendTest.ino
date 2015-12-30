void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

void loop() {
  while (Serial.available()) {
    Serial.println('a');
    digitalWrite(13, LOW);
  }
  digitalWrite(13, HIGH);
}

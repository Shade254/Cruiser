void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

void loop() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    switch(inChar) {
      case 'a':
        digitalWrite(13, HIGH);
      break;
      case 'b':
        digitalWrite(13, LOW);
      break;
    }
    Serial.println(inChar);
  }
}

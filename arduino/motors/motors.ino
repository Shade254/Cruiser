#define lbPin 7
#define laPin 6
#define raPin 4
#define rbPin 5


void setup() {
  pinMode(lbPin, OUTPUT);
  pinMode(laPin, OUTPUT);
  pinMode(rbPin, OUTPUT);
  pinMode(raPin, OUTPUT);

}

void loop() {
digitalWrite(raPin, HIGH);
digitalWrite(laPin, HIGH);
delay(1500);
digitalWrite(raPin, LOW);
digitalWrite(laPin, LOW);
delay(1500);


}

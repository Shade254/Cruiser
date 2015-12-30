#define trigPin 13
#define echoPin 12
#define xPin A0
#define yPin A1
#define zPin A2
#define lbPin 7
#define laPin 6
#define raPin 4
#define rbPin 5
int offX;
int offY;
int offZ;

void setup() {
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(lbPin, OUTPUT);
  pinMode(laPin, OUTPUT);
  pinMode(rbPin, OUTPUT);
  pinMode(raPin, OUTPUT);

  
offX = setOffset(A0);
offY = setOffset(A1);
offZ = setOffset(A2);
}

void loop() {
  sendInfo(getMess());
  delay(300);
  readValues();
}

void readValues(){
  int pomInt[] = {0,0,0,0};
  int pomCount = 0;
  char c;
  boolean was = false;
  while(Serial.available()>0){
    was = true;
    c = Serial.read();
    if(c=='-'){
      break;
    }
    else if(c == ';'){
      pomCount++;
    }
    else{
      pomInt[pomCount] = int(c)-48;
    }
  }
  if(was) handleMotion(pomInt[0], pomInt[1], pomInt[2], pomInt[3]);

  
}

String getMess(){
return getAccel() + getUS();
}


long getUS(){
  long duration, distance;
  digitalWrite(trigPin, LOW);  
  delayMicroseconds(2); 
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10); 
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = (duration/2) / 29.1;
  return distance;
}

String getAccel(){
float x = analogRead(A0) - offX;
float y = analogRead(A1) - offY;
float z = analogRead(A2) - offZ;
String pom = String(x) + ";" + String(y) + ";" + String(z) + ";";
return pom;
}

void sendInfo(String a){

    Serial.println(a);
}



float setOffset(int pin){
  int sample = 80;
  float pool;
  int wait = 40;
    for(int i = 0;i<sample;i++){
      pool+=analogRead(pin);
      delay(wait);
    }
    return pool/sample;
  }



  void handleMotion(int f, int l, int r, int b){
      digitalWrite(laPin,LOW);
      digitalWrite(lbPin,LOW);
      digitalWrite(raPin,LOW);
      digitalWrite(rbPin,LOW);


      if(f==1){
        digitalWrite(laPin, HIGH);
        digitalWrite(raPin, HIGH);
      }

      
      if(b==1){
        digitalWrite(lbPin, HIGH);
        digitalWrite(rbPin, HIGH);
      }
      
      if(l==1){
        digitalWrite(raPin, HIGH);
        digitalWrite(lbPin, HIGH);
      }
      
      if(r==1){
        digitalWrite(rbPin, HIGH);
        digitalWrite(laPin, HIGH);
      }

      delay(200);


     
  }



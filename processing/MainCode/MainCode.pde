import processing.serial.*;

String portName = "/dev/ttyACM1";
Serial myPort;
color bgColor = color(192,192,192);
color butColor = color(255, 153, 51);
PFont USFont, statFont;
PImage imgDown, imgUp, imgRight, imgLeft;
ImageButton[] buts = new ImageButton[4];
USPanel usPan;
Stat statistic;
int butWidth = 50;
int butHeight = 50;
boolean state = true;

void setup(){
  imgDown = loadImage("down.png");
  imgUp = loadImage("up.png");
  imgRight = loadImage("right.png");
  imgLeft = loadImage("left.png");
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
  
  size(640,480);
 background(bgColor);
  USFont = loadFont("Dialog.bold-48.vlw");
  statFont = loadFont("Dialog.bold-20.vlw");
 buts[0] = new ImageButton(450+50,300+0, imgUp);
 buts[1] = new ImageButton(450+0,300+butHeight,imgLeft);
 buts[2] = new ImageButton(450+2*butWidth,300+butHeight, imgRight);
 buts[3] = new ImageButton(450+butWidth,300+2*butHeight,imgDown);
 usPan = new USPanel();
 statistic = new Stat();
 

   String pom = myPort.readStringUntil('\n');
  pom = null;
  
 
}

void draw(){
  if(myPort.available()>0){
    handleSerial(myPort.readStringUntil('\n'));
  }
  sendData();
  delay(500);
}

void sendData(){
  int array[] = {0,0,0,0};
  if(mousePressed){
    for(int i = 0;i<array.length;i++){
      if(buts[i].myArea(mouseX, mouseY)){
        array[i] = 1;
        state = false;
        sendData(array);
      }
    }
  }
  else{
   if(keyPressed){
     if(keyCode == UP) array[0] = 1;
     if(keyCode == LEFT) array[1] = 1;
     if(keyCode == RIGHT) array[2] = 1;
     if(keyCode == DOWN) array[3] = 1;
     state = false;
     sendData(array);
   }
   else if(!state){
     state = true;
     sendData(array);
   }
  }
}
void sendData(int array[]){
         myPort.write(array[0] + ";" + array[1] + ";" + array[2] + ";" + array[3] + "-");
         //println(array[0] + ";" + array[1] + ";" + array[2] + ";" + array[3] + "\n");
}

void handleSerial(String mssg){
 
  if(mssg!=null){
     println(mssg);
    float mess[] = float((split(mssg, ';')));
    
    
    if(abs(mess[0])<20 && abs(mess[1])<20&&abs(mess[2])<20){
      background(bgColor);
      buts[0].drawMe();
      buts[1].drawMe();
      buts[2].drawMe();
      buts[3].drawMe();
      if(mess.length >= 4){
      //println(mess[0] + "---" + mess[1] + "---" + mess[2] + "---" + mess[3]);
      usPan.update(mess[3]);
      statistic.update(mess[0], mess[1], mess[2]);
    }
    }
  }
}














class ImageButton{
  float posX;
  float posY;
  float w;
  float h;
  color bgColor;
  PImage ic;
  
 ImageButton(float x, float y, PImage icon){
   posX = x;
   posY = y;
   w = butWidth;
   h = butHeight;
   bgColor = butColor;
   ic = icon;
   drawMe();
 }
 
 void drawMe(){
   fill(bgColor);
   rect(posX, posY, w, h);
   image(ic, posX, posY, w, h);
 }
 
 boolean myArea(float pX, float pY){
   if(pX>posX && pX<posX+w){
     if(pY > posY && pY<posY+h){
       return true;
     }
   }
   return false;
 }
  
}

























class USPanel{
 float rectX = 410;
 float rectY = 10;
 float rectH = 60;
 float rectW = 250;
 float textX = 415;
 float textY = 53;
 
 USPanel(){
   update(0);
 }
 void update(float cm){
   textFont(USFont);
   if(cm>5){
     fill(0);
   }
   else{
     fill(color(255,0,0));
   }
   
   rect(rectX,rectY,rectW, rectH);
   fill(255);
   text(cm + "cm", textX, textY);
 }
  
}















class Stat{
  float posY = 30;
  float posX = 30;
  float spaces = 40;
  Bars bars = new Bars();
  Stat(){
   update(0, 0, 0); 
  }
  
  
 void update(float x, float y, float z){
   
      textFont(statFont);
      fill(0);
      text("Acceleration(X):   " + x, posX, posY);
      text("Acceleration(Y):   " + y, posX, posY + 1*spaces);
      text("Acceleration(Z):   " + z, posX, posY + 2*spaces);
      bars.update(x, y, z);
 }
}


class Bars{
  int maxSpeed = 20;
  int barHeight = 25;
  int barWidth = 350;
  int spacing = 40;
  int posX = 10;
  int posY = 350;
  
  void update(float x, float y, float z){
     fill(255);
     rect(posX, posY, barWidth, barHeight);
     rect(posX, posY+spacing, barWidth, barHeight);
     rect(posX, posY+2*spacing, barWidth, barHeight);
     fill(getColor(x));
     rect(posX, posY, getWidth(x), barHeight);
     fill(getColor(y));
     rect(posX, posY+spacing, getWidth(y), barHeight);
     fill(getColor(z));
     rect(posX, posY+spacing*2, getWidth(z), barHeight);


     
  }
  float getWidth(float i){
    return (abs(i)*barWidth/maxSpeed);
  }
  color getColor(float i){
      if(i>0){
       return (color(255,0,0));
     }
     else{
        return color(0,0,255); 
     }
  }
  
}
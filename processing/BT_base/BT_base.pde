import processing.serial.*;
 
Serial myPort;
String BTportName = "/dev/rfcomm0";
color bgColor; 
float x = 100;
float y = 50;
float w = 150;
float h = 80;




void setup()
{
  println(Serial.list());
   size(640, 480);
   if(isBT(Serial.list())){
     myPort = new Serial(this, BTportName, 9600);
     bgColor = color(102);
   }
   else{
      println("No BT found, sorry"); 
      exit();
   }
}
 
 
 
void draw(){
  //println(myPort.available());
 background(bgColor);
 rect(x,y,w,h);
 fill(255);
 /*if(mousePressed){
  if(mouseX>x && mouseX <x+w && mouseY>y && mouseY <y+h){
   fill(0);
   println(viaBT('1'));
  }
 } 
  viaBT('0');*/
   viaBT('a');
  
}



boolean viaBT(char a){
  if ( myPort.available() > 0) {  
   myPort.write(a);
   delay(100); 
   return true;
  }
  else{
    //println(myPort.available());
    return false;
  }
}

boolean isBT(String[] serialNames){
  for(int i = 0;i<serialNames.length;i++){
    if(serialNames[i].equals(BTportName)){
      return true;
    }
  }
  
  return false;
}
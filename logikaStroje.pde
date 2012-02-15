/**
*  Code by Krystof Pesek, licensed under Creative Commons Attribution-Share Alike 3.0 license.
*  License: http://creativecommons.org/licenses/by-sa/3.0/
*
* visit more @ http://vimeo.com/kof
* if you leave this header, bend, share, spread the code, it is a freedom!
*
*   ,dPYb,                  ,dPYb,
*   IP'`Yb                  IP'`Yb
*   I8  8I                  I8  8I
*   I8  8bgg,               I8  8'
*   I8 dP" "8    ,ggggg,    I8 dP
*   I8d8bggP"   dP"  "Y8ggg I8dP
*   I8P' "Yb,  i8'    ,8I   I8P
*  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
*  88P      Y8P"Y8888P"    PI8"8888
*                           I8 `8,
*                           I8  `8,
*                           I8   8I
*                           I8   8I
*                           I8, ,8'
*                            "Y8P'
*
*/


import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

Hlas hlas;

ArrayList inputs;
ArrayList konektory;
ArrayList zarovky;

int numInputs = 4;
int numKonektors = 16;
int numZarovek = 4;

int x[] = {80,160,240,320};
int y[] = {200,200,200,200};

int [] zarovkaPwm = {8,9,10,11};
int [] spinacPin = {0,1,2,3};
int [] matrixPin = {4,5,6,7,8,9,10,11};
float power = 127;

void setup(){
  size(640,280);
  
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  for (int i = 0; i < spinacPin.length; i++)
    arduino.pinMode(spinacPin[i], Arduino.INPUT);
    
    
  
  //smooth();
  inputs = new ArrayList();

  konektory = new ArrayList();
  zarovky = new ArrayList();

  for(int i =0 ; i < numInputs;i++){
    inputs.add(new Input(i,x[i],y[i],false));
  }
  
  hlas = new Hlas();

  float X = 400;
  float Y = 20;
  for(int i =0 ; i < numKonektors;i++){
    konektory.add(new Konektor(i,X,Y,false));
    X+= 40;
    if((i+1)%4==0){
      X=400;
      Y+=40;
    }
  }

  X = 80;
  Y = 20;

  for(int i =0 ; i < numZarovek;i++){
    zarovky.add(new Zarovka(i,X,Y,false));
    X+= 40;
  }
}

void draw(){

  background(255);
  
  drawAll();
  sendZarovky();
}


void drawAll(){
  for(int i = 0 ; i < inputs.size(); i++){
    Input in = (Input)inputs.get(i);
    in.draw();
  }
  for(int i =0 ; i < konektory.size();i++){
    Input in =  (Input)konektory.get(i);
    in.draw();
  }
  for(int i =0 ; i < zarovky.size();i++){
    Zarovka in =  (Zarovka)zarovky.get(i);
    in.draw();
  } 
}

/////////////////////////////////////////
void sendZarovky(){
  for(int i =0 ; i < zarovky.size();i++){
    Zarovka in =  (Zarovka)zarovky.get(i);
    arduino.analogWrite(zarovkaPwm[i],(int)map(in.dim,0,255,0,power));
    in.dim = (sin((frameCount+i*15.0)/15.0)+1.0)*255;
  }
  
  
}
int c = 0;

void dispose(){
  for(int i =0 ; i < zarovky.size();i++){
    Zarovka in =  (Zarovka)zarovky.get(i);
    arduino.analogWrite(zarovkaPwm[i],0);
  }
  super.dispose(); 
}


class Input{
  float x,y;
  int id;
  boolean state;
  int w,h;

  color c2 = color(255);
  color c1 = color(255,0,0);

  Input(int _id,float _x,float _y,boolean _state){
    x = _x;
    y = _y;
    id = _id;
    state =  _state;

    w = 20;
    h = 30;
  }

  void draw(){
    fill(state ? c1 : c2); 
    rect( x , y , w , h );
    checkState();
    //println(state);
  }
  
  void checkState(){
    int val = arduino.analogRead(spinacPin[id]);
    println(id+": "+val);
    if(val > 1000){
      
     state=true; 
    }else{
     state=false; 
    }
  }

  boolean over(){
    boolean answ = false;

    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
      answ = true;
    return answ;
  }
}

class Konektor extends Input{

  Konektor(int _id,float _x,float _y,boolean _state){
    super(_id,_x,_y,_state);
  }

  void draw(){
    fill(state?c1:c2); 
    ellipse(x,y,w,w);
  }
  boolean over(){
    boolean answ = false;

    if(mouseX > x-w && mouseX < x+w && mouseY > y-w && mouseY < y+w)
      answ = true;
    return answ;

  }
  
}


class Zarovka extends Input{
  float dim = 0;
  boolean dimming = false;

  boolean state = true;
  Zarovka(int _id,float _x,float _y,boolean _state){
    super(_id,_x,_y,_state);

    c1 = color(#ffcc00);
    c2 = color(#ccff00); 
  }

  void draw(){
    fill(state?c1:c2,dim); 
    ellipse(x,y,w,w);
  }
  
  void setDim(float _dim){
    dim = dim;
  }

  void blik(){
    dimming = true;
  }
  
  
} 


void mousePressed(){
  for(int i = 0 ; i < inputs.size(); i++){
    Input in = (Input)inputs.get(i);
    if(in.over()){
      in.state = !in.state;
    }
  }

  for(int i = 0 ; i < konektory.size(); i++){
    Konektor in = (Konektor)konektory.get(i);
    if(in.over()){
      in.state = !in.state;
    }
  }
  mousePressed = false;
}


void keyPressed(){

hlas.mluv("fin.txt");
}

/*
class Hadnaka{
  int mode = 0;
 // int [] combo = [1,3,4,2];

  int state;

  Hadanka(){
    

  }

  void sucess(){
    for(int i = 0 ; i < zarovky.size();i++){
      Zarovka z = (Zarovka)zarovky.get(i);
      z.blink();
    }

  }

  void no(){


  }

}*/

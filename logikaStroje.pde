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



/// debugging
////////////////////////
float power = 255;
int mode = 0;
//////////////////////


Arduino arduino;

Hlas hlas;

Morse morse;

boolean odblokovan = false;

ArrayList inputs;
ArrayList konektory;
ArrayList zarovky;

int numInputs = 4;
int numKonektors = 2;
int numZarovek = 4;

boolean states[] = {false,false};
boolean pstates[] = {false,false};

int x[] = {
  80, 160, 240, 320
};
int y[] = {
  200, 200, 200, 200
};

int [] zarovkaPwm = {
  11, 9, 10, 8
};
int [] spinacPin = {
  0, 1, 2, 3
};
int [] matrixPin = {
  4,5
};

int [] chapter0 = {
  255, 255, 255, 255
};

int [] chapter1 = {
  0, 0, 0, 0
};
int [] chapter2 = {
  255, 0, 0, 0
};
int [] chapter3 = {
  255, 255, 0, 0
};
int [] chapter4 = {
  255, 255, 255, 0
};
int [] chapter5 = {
  255, 255, 255, 255
};
int [] chapter6 = {
  255, 0, 255, 0
};


void setup() {
  size(640, 400, P2D);

  frameRate(25);



  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0]);

  for (int i = 0; i < spinacPin.length; i++)
    arduino.pinMode(spinacPin[i], Arduino.ANALOG);
    
    for (int i = 0; i < matrixPin.length; i++)
    arduino.pinMode(matrixPin[i], Arduino.ANALOG);


  


  //smooth();
  inputs = new ArrayList();
  konektory = new ArrayList();
  zarovky = new ArrayList();


  for (int i =0 ; i < numInputs;i++) {
    inputs.add(new Input(i, x[i], y[i], false));
  }

  hlas = new Hlas();

  float X = 400;
  float Y = 20;
  for (int i =0 ; i < numKonektors;i++) {
    konektory.add(new Konektor(i, X, Y, false));
    X+= 40;
    if ((i+1)%4==0) {
      X=400;
      Y+=40;
    }
  }

  X = 80;
  Y = 20;

  for (int i =0 ; i < numZarovek;i++) {
    zarovky.add(new Zarovka(i, X, Y, false));
    X+= 40;
  }
  
  morse = new Morse();
  
}

void keyPressed(){
 
}

void readKonektors() {

  for (int i =0 ; i < konektory.size();i++) {
    Konektor k = (Konektor)konektory.get(i);
    k.update();
    //print(k.state+" ")
    
  } 
  //println("");
}

int timer = 0;
int cntr = 0;

void draw() {
  
  ///buzerace
  
  
  
  if(frameCount%2000==0 && timer > 500 && mode > 0 && mode <= 5){
    hlas.mluv("buz"+(int)random(1,6)+".txt");
    timer = 0;
  }

  background(255);


  if (frameCount%3==0) 
    readKonektors();

  drawAll();

  Input enter = (Input)inputs.get(0);
  Konektor valid1 = (Konektor)konektory.get(0);
Konektor valid2 = (Konektor)konektory.get(1);


  states[0] = valid1.state;
  states[1] = valid2.state;

  timer ++;

  switch(mode) {
    //////////////////////////////////////////
  case 0:



    //waveZarovky();
    timer ++;
    if (enter.state && timer > 50) {
    
      pstates[0] = states[0] = false;
      pstates[1] = states[1] = false;
      
      timer = 0;
      //blikAll();
      hlas.mluv("0.txt");
      
      for (int i =0 ; i < zarovky.size();i++) {
      Zarovka in =  (Zarovka)zarovky.get(i);
      in.dim = chapter0[i];
      in.update();
    }
      
      
      delay(15000);
      mode = 1;
      println(mode);
    }
    break; 
  case 1:

    //////////////////////////////////////////
    timer++;
    if (enter.state && timer>50 && !states[0] && states[1] ) {
      timer = 0;
      pstates[0] = states[0];
      pstates[1] = states[1];
      

      hlas.mluv("1.txt");
      delay(15000);
      mode = 2; 
      
      println(mode);
    }else if(enter.state && timer>50){
      timer=-1000;
      hlas.mluv("errUsr.txt");
      delay(15000);
      
    }

    for (int i =0 ; i < zarovky.size();i++) {
      Zarovka in =  (Zarovka)zarovky.get(i);
      in.dim = chapter1[i];
      
    }

    break; 
  case 2:

    //////////////////////////////////////////
    timer++;
    if (enter.state && timer>50 && states[0] && !states[1] && !pstates[0] && pstates[1]) {
      timer = 0; 
      
      
      pstates[0] = states[0];
      pstates[1] = states[1];
      
      hlas.mluv("2.txt");
      delay(15000);

      mode = 3; 
      println(mode);
    }else if(enter.state && timer>50){
      timer=-1000;
      hlas.mluv("errUsr.txt");
      delay(15000);
    }


    for (int i =0 ; i < zarovky.size();i++) {
      Zarovka in =  (Zarovka)zarovky.get(i);
      in.dim = chapter2[i];
    }

    break; 
  case 3:




    timer++;
    if (enter.state && timer>50 && states[0] && !states[1] && pstates[0] && !pstates[1]) {
      timer=0; 
      
      
      pstates[0] = states[0];
      pstates[1] = states[1];
      
      hlas.mluv("3.txt");
      delay(15000);

      mode = 4; 
      println(mode);
    }else if(enter.state && timer>50){
      timer=-1000;
      hlas.mluv("errUsr.txt");
      delay(15000);
    }
    
    
    for (int i =0 ; i < zarovky.size();i++) {
      Zarovka in =  (Zarovka)zarovky.get(i);
      in.dim = chapter3[i];
    }


    

    //////////////////////////////////////////


    break; 
  case 4:
    timer++;
    if (enter.state && timer>50 && !states[0] && states[1] && pstates[0] && !pstates[1]) {
      
   
      
      pstates[0] = states[0];
      pstates[1] = states[1];
      
      timer=-1000; 
      hlas.mluv("4.txt");
      delay(15000);

      mode = 5; 
      println(mode);
      
    }else if(enter.state && timer>50){
      timer=-1000;
      hlas.mluv("errUsr.txt");
      delay(15000);
    }


    for (int i =0 ; i < zarovky.size();i++) {
      Zarovka in =  (Zarovka)zarovky.get(i);
      in.dim = chapter4[i];
    }

    //////////////////////////////////////////

    break; 
  case 5:
  
  for (int i =0 ; i < zarovky.size();i++) {
      Zarovka in =  (Zarovka)zarovky.get(i);
      in.dim = chapter5[i];
    }
    
    
    boolean trues[] = new boolean[3];
  for (int i = 0 ; i < 3 ;i++) {
    Input input = (Input)inputs.get(i+1);
    trues[i] = input.state;
  
  }  
    
    if(enter.state && timer>50 && !odblokovan){
      odblokovan = true;
      hlas.mluv("5.txt");
      timer = 0;
      
      delay(25000);
      
      
      morse.zprava();
      
      
      
      
    }
    
    
    
    if(cntr == 0 && enter.state && odblokovan && timer>50 && !trues[2] && !trues[1] && !trues[0]){
      timer = 0;
      cntr = 1;
      hlas.rekni("nula");
    }
    
    
    
    if(cntr == 1 && enter.state && odblokovan && timer>50 && !trues[2] && !trues[1] && trues[0]){
      timer = 0;
      cntr = 2;
      hlas.rekni("jedna");
    }
    
    
    
    if(cntr == 2 && enter.state && odblokovan && timer>50 && !trues[2] && trues[1] && !trues[0]){
      timer = 0;
      cntr = 3;
      hlas.rekni("dva");
    }
    
    
    
    if(cntr == 3 && enter.state && odblokovan && timer>50 && !trues[2] && trues[1] && trues[0]){
      timer = 0;
      cntr = 4;
      hlas.rekni("tři");
    }
    
    
    if(cntr == 4 && enter.state && odblokovan && timer>50 && trues[2] && !trues[1] && !trues[0]){
      timer = 0;
      cntr = 5;
      hlas.rekni("čtyři");
    }
    
    
    if(cntr == 5 && enter.state && odblokovan && timer>50 && trues[2] && !trues[1] && trues[0]){
      timer = 0;
      cntr = 6;
      hlas.rekni("pět");
    }
    
    
    if(cntr == 6 && enter.state && odblokovan && timer>50 && trues[2] && trues[1] && !trues[0]){
      timer = 0;
      cntr = 7;
      hlas.rekni("šest");
    }
    
    
    if(cntr == 7 && enter.state && odblokovan && timer>50 && trues[2] && trues[1] && trues[0]){
      timer = 0;
      cntr = 7;
      hlas.rekni("sedm");
      
      
    
      hlas.mluv("6.txt");
      delay(15000);
      mode = 6;
    }
    
    
    
    
      
    if( cntr == 0 && enter.state && odblokovan && timer>50){
      timer = 0;
      morse.zprava();
      delay(15000);
      
    }

    //////////////////////////////////////////

    break;
    
    case 6:
    
    for (int i =0 ; i < zarovky.size();i++) {
      Zarovka in =  (Zarovka)zarovky.get(i);
      in.dim = chapter6[(int)((i+(frameCount/25.0))%chapter6.length)];
    }
    
    if(enter.state && timer>50){
      
      timer = 0;
      hlas.mluv("7.txt");
      delay(15000);
      mode = 7;
    }
    
    break;
    
    case 7:
    
    
    for (int i =0 ; i < zarovky.size();i++) {
      Zarovka in =  (Zarovka)zarovky.get(i);
      in.dim = chapter6[(int)((i+(frameCount/18.0))%chapter6.length)];
    }
    
    if(enter.state && timer>50){
      timer = -5000;
     
      
      delay(5000);
      
      hlas.mluv("fin.txt");
      
      delay(50000);
      
    }
      
    break;
    

  default:
  }
}


void drawAll() {
  for (int i = 0 ; i < inputs.size(); i++) {
    Input in = (Input)inputs.get(i);
    in.draw();
  }
  for (int i =0 ; i < konektory.size();i++) {
    Input in =  (Input)konektory.get(i);
    in.draw();
  }
  for (int i =0 ; i < zarovky.size();i++) {
    Zarovka in =  (Zarovka)zarovky.get(i);
    in.draw();
  }
}

/////////////////////////////////////////
int c = 0;


void blikAll() {
  for (int i =0 ; i < zarovky.size();i++) {
    Zarovka in =  (Zarovka)zarovky.get(i);
    in.state = true;
  }
}

void waveZarovky(int faze) {
  for (int i =0 ; i < zarovky.size();i++) {
    Zarovka in =  (Zarovka)zarovky.get(i);
    arduino.analogWrite(zarovkaPwm[i], 255);
  }
}


ArrayList inputs;
ArrayList konektory;
ArrayList zarovky;

int numInputs = 4;
int numKonektors = 16;
int numZarovek = 4;

int x[] = {80,160,240,320};
int y[] = {200,200,200,200};

void setup(){

  size(640,280);


  smooth();
 inputs = new ArrayList();

  konektory = new ArrayList();
  zarovky = new ArrayList();

 for(int i =0 ; i < numInputs;i++){
    inputs.add(new Input(i,x[i],y[i],false));
 }


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


 Zarovka z = (Zarovka)zarovky.get(0);
 z.blik();
 
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


    fill(state?c1:c2); 

    rect(x,y,w,h);


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

  Zarovka(int _id,float _x,float _y,boolean _state){
   super(_id,_x,_y,_state);

   c1 = color(#ffcc00);
  }

  void draw(){

    if(dimming && dim < 255){
      dim+=2;
    }else if(dim > 0){
      dim-=2;
    }else{
      dimming = false;
    }

    fill(state?c1:c2,dim); 

    ellipse(x,y,w,w);
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

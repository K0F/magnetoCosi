ArrayList inputs;
int numInputs = 4;

int x[] = {80,160,240,320};
int y[] = {300,300,300,300};

void setup(){

  size(640,280,P2D);


 inputs = new ArrayList();

 for(int i =0 ; i < numInputs;i++){
    inputs.add(new Input(i,x[i],y[i],false));
 }
}



void draw(){



}



class Input{
  float x,y;
  int id;
  boolean state;
  int w,h;


  Input(int _id,float _x,float _y,boolean _state){
    x = _x;
    y = _y;
    id = _id;
    state =  _state;

    w = 10;
    h = 20;
  }



  void draw(){


    if(over() && mousePressed)
      state = !state
    rect(x,y,20,10)


  }

  boolean over(){
    boolean answ = false;

    if(mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
      answ = true;


    return answ;

  }
}

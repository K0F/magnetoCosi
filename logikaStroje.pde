

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


  Input(int _id,float _x,float _y,boolean _state){

    x = _x;
    y = _y;
    id = _id;
    state =  _state;


  }



  void draw(){



  }



}

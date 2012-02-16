
class Input {
  float x, y;
  int id;
  boolean state;
  int w, h;

  color c2 = color(255);
  color c1 = color(255, 0, 0);

  Input(int _id, float _x, float _y, boolean _state) {
    x = _x;
    y = _y;
    id = _id;
    state =  _state;

    w = 20;
    h = 30;
  }

  void draw() {
    fill(state ? c1 : c2); 
    rect( x, y, w, h );
    
    
    checkState();
    //println(id+": "+state);
  }

  void checkState() {
    int val = arduino.analogRead(spinacPin[id]);
    //println(id+": "+val);
    if (val > 1000) {
      state=true;
    }
    else {
      state=false;
    }
  }

  boolean over() {
    boolean answ = false;

    if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h)
      answ = true;
    return answ;
  }
}



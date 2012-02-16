
class Konektor extends Input {

  Konektor(int _id, float _x, float _y, boolean _state) {
    super(_id, _x, _y, _state);
  }

  void draw() {
    fill(state?c1:c2); 
    ellipse(x, y, w, w);
  }

  boolean over() {
    boolean answ = false;

    if (mouseX > x-w && mouseX < x+w && mouseY > y-w && mouseY < y+w)
      answ = true;
    return answ;
  }

  void update() {
    int val = arduino.analogRead(matrixPin[id]);
   // print(val);
    if (val > 100) {
      state = true;
    }    
    else {
      state = false;
    }
  }
}


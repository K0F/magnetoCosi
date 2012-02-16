
class Zarovka extends Input {
  float dim = 0;
  boolean dimming = false;
  boolean state = false;
  
  Zarovka(int _id, float _x, float _y, boolean _state) {
    super(_id, _x, _y, _state);

    c1 = color(#ffcc00);
    c2 = color(#ccff00);
  }

  void draw() {
    
    /*if(state){
     dim = random(200,255);
    }else{
     dim = 0;
    }*/
    
    
    
    update();
    
    
    
    fill(state?c1:c2, dim); 
    ellipse(x, y, w, w);
  }
  
  void update(){
   arduino.analogWrite( zarovkaPwm[id] , (int)map(dim, 0, 255, 0, power) ); 
  }

  void setDim(float _dim) {
    dim = dim;
  }

  void blik() {
    dimming = true;
  }
} 


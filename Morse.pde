class Morse{
  // cihelna brana
  String msg = " -.-. .. .... . .-.. -. .-  -... .-. .- -. .- ";
  
  

  Morse(){
    
   arduino.pinMode(22, Arduino.OUTPUT); 
  }
  
  void zprava(){
    
    
    for(int i =0 ;i<msg.length();i++){
      
     if(msg.charAt(i)=='.'){
      tecka();
      print(".");
     }else if(msg.charAt(i)=='-'){
       carka();
      print("-"); 
     }else if(msg.charAt(i)==' '){
      pomlka(); 
     }
     
     //delay(100);
    }
    
  }






  void pomlka(){
    arduino.digitalWrite(22, 0);
   delay(2000); 
    
    
  }

  void tecka() {
    arduino.digitalWrite(22, 0);
    delay(100);
    arduino.digitalWrite(22, 1);
    delay(100);
    arduino.digitalWrite(22, 0); 
    delay(1000);
  }

  void carka() {
    
    arduino.digitalWrite(22, 0);
    delay(100);
    arduino.digitalWrite(22, 1);
    delay(100);
    arduino.digitalWrite(22, 0);
    delay(100);
    arduino.digitalWrite(22, 1);
    delay(100);
    arduino.digitalWrite(22, 0);
    
    arduino.digitalWrite(22, 0);
    delay(1000);
    
    
  }
}


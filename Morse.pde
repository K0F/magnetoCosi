class Morse{
  // 50.0652 N, 14.4192 E
  String msg = "..... ----- .-.-.- ----- -.... ..... ..---   -. --..--   .---- ....- .-.-.- ....- .---- ----. ..---   . ";
  
  

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
     }else{
      pomlka(); 
     }
     
     //delay(100);
    }
    
  }






  void pomlka(){
    arduino.digitalWrite(22, 0);
   delay(500); 
    
    
  }

  void tecka() {
    arduino.digitalWrite(22, 1);
    delay(50);
    arduino.digitalWrite(22, 0); 
    delay(200);
  }

  void carka() {
    arduino.digitalWrite(22, 1);
    delay(200);
    arduino.digitalWrite(22, 0); 
    delay(200);
  }
}


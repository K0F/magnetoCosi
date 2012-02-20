class Hlas{
  String command = "espeak -v cs -s 30 -f ";
  String rek = "espeak -v cs -s 30 ";
  String [] kecy;
  String filename = "1.txt";
  
  
  Hlas(){
    }
  
  void mluv(String _filename){
    
    filename = _filename;
    
    
    kill();
    
    delay(100);
    
    
    
    try{  
      Runtime.getRuntime().exec(command+""+sketchPath+"/data/"+filename);    
    }catch(Exception e){
      
    }
    
  }
  
  void rekni(String _in){
    try{  
      Runtime.getRuntime().exec(rek+" "+_in);    
    }catch(Exception e){
      
    }
    
    
  }
  
  void kill(){
    try{  
      Runtime.getRuntime().exec("killall espeak");    
    }catch(Exception e){
      
    }
    
  }
  
  
  
}

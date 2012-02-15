class Hlas{
  String command = "espeak -v cs -a 200 -s 10 -f ";
  String [] kecy;
  String filename = "1.txt";
  
  
  Hlas(){
    }
  
  void mluv(String _filename){
    
    filename = _filename;
    try{  
      Runtime.getRuntime().exec(command+""+sketchPath+"/data/"+filename);    
    }catch(Exception e){
      
    }
    
  }
  
  
  
}

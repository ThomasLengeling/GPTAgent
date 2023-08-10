class GlobalClock {
    
  //int base_framecount = 0;
  int base_millis = 0;
  int speedFactor = 60*25;
  
  GlobalClock() {
    //base_framecount = frameCount;
    base_millis = getMillis();
  }
  
  private int getMillis() {
    return  millis() * speedFactor;
  }
  
  int[] getCurrentTime() {
    int elapsed_millis = (getMillis() - base_millis);
    int millis = elapsed_millis % 1000 ;
    int seconds = (elapsed_millis / 1000) % 60;
    int minutes = (elapsed_millis / (60*1000)) % 60;
    int hours = (elapsed_millis / (60*60*1000)) % 24;
    return new int[] {hours, minutes, seconds, millis};
  }
  
  float getCurrentTimeStamp() {
    int elapsed_millis = (getMillis() - base_millis);
    return elapsed_millis / 1000;
  }
  
  void setGlobalClock(int hours, int minutes, int seconds, int millis) {
    int current_millis = getMillis();
    
    millis = millis % 60;
    seconds = seconds % 60;
    minutes = minutes % 60;
    hours = hours % 24;
    int offset = millis + seconds * 1000 + minutes * (60*1000) + hours * (60*60*1000);
    // keep the min value of clock non-negative
    if (offset < 0) offset = 0;  
    base_millis = current_millis - offset;
    
  }
}

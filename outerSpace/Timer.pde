class Timer {

  int savedTime; //when timer started
  int totalTime; //how long timer should last

  Timer (int tempTotalTime) { //the value of the total time = 5000 millisec.
    totalTime = tempTotalTime; //initialize the total Time
  } 

  void start () {
    savedTime = millis();
  }

  boolean finished() {
    int passedTime = millis() - savedTime; //check how much time has passed
    if (passedTime > totalTime) {
      return true; //if 5 secs have passed
    } 
    else {
      return false;
    }
  }
}


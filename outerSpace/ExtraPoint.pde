class ExtraPoint {

  int pointX;
  int pointY;
  PImage extraImg;

  ExtraPoint(int pointX, int pointY, PImage extraImg) {
    this.pointX = pointX;
    this.pointY = pointY;
    this.extraImg = extraImg;
  }

  void drawExtra() {
    imageMode(CORNERS); 
    image(extraImg, pointX, pointY);
  }    

  void lifeCatch(int posx, int  posy) {   
    if (dist(pointX, pointY, posx, posy) < 20) {  //check the distance between the coordinates of the ship and the extra points
      catched = true;
      life++;
      deaths--;
      pointX = -100;
      pointY = -100;
      player7.trigger();
    }
    else {
      catched = false;
    }
  }
}


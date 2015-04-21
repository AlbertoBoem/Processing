class Alien {

  int posX;
  int posY;
  PImage alienImg;
  boolean isActive;

  Alien (int posX, int posY, PImage alienImg) {
    this.posX = posX;
    this.posY = posY;
    this.alienImg = alienImg;
    this.isActive = false;
  }

  //Function for animate the alien on the screen
  void moveAlien() {
    if (posY > height) { 
      posY = -alienImg.height;
      randomX();
    }
    posY++;
  }

  void randomX() {
    posX = (int)random(alienImg.width, width);
  } 

  void randomY() {
    posY = (int)random(-alienImg.height, height);
  }

  //Function if reach the bottom of screen
  boolean reachBottom () {
    if (posY > alienImg.height) {
      return true;
    } 
    else {
      return false;
    }
  }

  //Function for displaying the aliens
  void drawAlien() {
    imageMode(CORNERS); 
    image(alienImg, posX, posY);
  }
}


class Asteroid extends Alien {  //the class takes the variables and the functions   

  Asteroid(int posX, int posY, PImage alienImg) {
    super(posX, posY, alienImg); //runs the constructor of the superclass
  }

  void drawAsteroid() {
    pushMatrix();
    translate(posX, posY); 
    rotate(millis()/500.0);
    imageMode(CORNERS);
    image(alienImg, 0, 0);
    popMatrix();
  }
}



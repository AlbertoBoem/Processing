////////////////////////////////////////////////
/*
 OUTER SPACE
 
 NOTES: - follow the instructions,
        - use the arrow key for move the ship,
        - press x for shooting.
 */
////////////////////////////////////////////////

//Load library
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

//Pointers
Alien[] aliens; //for dynamic creation of an array aliens
Asteroid[] asteroids; //for dynamic creation of an array asteroids
ExtraPoint[] extraLife; //for dynamic creation of an array of objects for extra point

Timer timer; 
Timer timerLifeUp; //for dynamic creation of a timer object

//Variables
Minim sound_track; 
AudioPlayer player1;

Minim sound_tracka; 
AudioSample player1a; 

Minim sound_startplane; 
AudioSample player2; 

Minim sound_bullet; 
AudioSample player3; 

Minim sound_explAlien;
AudioSample player5;

Minim sound_explShip;
AudioSample player6;

Minim sound_catchLife;
AudioSample player7; //Audio objects

PImage image_intro;
PImage image_starship;
PImage image_bullet;
PImage image_alien;
PImage image_asteroid;
PImage image_boom;
PImage image_life;
PImage image_boom2; //Declare a variable of type PImage

int shipX = 200;
int shipY = 350; //Variables for set the initial position of the Space ship

int bulletX;
int bulletY; //Variables for keep the position of the bullet

float val = 1.2; //Variable for displaying aliens

int speed = 2; //Speed value of the bullet

int mode = 0; //Variable for keep track of the different states of the game

int life = 3; 
int score = 0; 
int deaths = 0; //Variables for set and keep track to the score 

int totalAliens = 0; 
int totalAsteroids = 0;
int totalExtra = 0; //Variables for keep track of the total amount of the objects

int allAlien = 50;  
int allAsteroid = 50; 
int allExtra = 4; //The maximum amount of the objects visible on the screen 

int counter = 0; //Variable that count for display objects

boolean catched = false; //Variable for check if the ship catch the objects for extra points

boolean alert = false; //Varibale for check the 'state of alert'

//-------------------------------------------------

void setup () {
  size (400, 400);

  //Audio files
  sound_track = new Minim(this); //Create a new Minim object
  player1 = sound_track.loadFile("OuterSpace.wav"); //Load the audio file

  sound_tracka = new Minim(this); //Create a new Minim object
  player1a = sound_tracka.loadSample("OuterSpace.wav"); //Load the audio file

  sound_startplane = new Minim(this); 
  player2 = sound_startplane.loadSample("start.wav"); //for starting

  sound_bullet = new Minim(this);
  player3 = sound_bullet.loadSample("fire.wav"); //Sound of the bullet

  sound_explAlien = new Minim(this);
  player5 = sound_explAlien.loadSample("expl02.wav"); //for the explosion of the aliens

  sound_explShip = new Minim(this);
  player6 = sound_explShip.loadSample("expl01.wav"); //for the explosion of the ship

  sound_catchLife = new Minim(this);
  player7 = sound_catchLife.loadSample("catch.wav"); //for underline that the ship catch a new life

    //Load image files
  image_intro = loadImage("weird001.png");
  image_starship = loadImage ("main_ship.png");
  image_bullet = loadImage ("bullet.png");
  image_alien = loadImage ("alien_ship.png");
  image_asteroid = loadImage("asteroid.gif");
  image_boom = loadImage ("boom.png");
  image_life = loadImage("star.png");
  image_boom2 = loadImage("boom4.gif"); 

  //Declare new array 
  aliens = new Alien[allAlien];
  asteroids = new Asteroid[allAsteroid];
  extraLife = new ExtraPoint[allExtra];
  timer = new Timer(3000); 
  timerLifeUp = new Timer(10000);

  //Load the function for create different objects
  createAlien();
  createAsteroid();
  createExtraPoint();

  //load the function for starting the timer object
  timer.start();
  timerLifeUp.start();

  smooth();

  frameRate(60);
}

//---------------------------------------------------------

void draw () {
  noTint();

  //Initial screen
  if (mode == 0) {    
    background (0);
    textSize(60);
    fill(81, 245, 32);
    textAlign(LEFT, TOP);
    text("OUTER", 90, 100); //game title
    textSize(60);
    text("SPACE", 98, 150);
    player1.play();
    starField();
    if (frameCount >= 600) { //when catch the frame number 600 load this
      mode = 1;  
      sound_track.stop();
      sound_tracka.stop();
    }
  }
  
  //Introduction screen
  if (mode == 1) {    
    background (0);
    introScreen(); //load the function
    if (frameCount >= 1000) {
      textSize(20);
      fill(101, 112, 232);
      text("PRESS ENTER TO START", 90, 150);
    }
  }  

  //The game 
  if (mode == 2) {
    background (0);
    catched = false;

    //Draw the space ship and the bullet
    imageMode (CENTER);
    image (image_bullet, bulletX, bulletY);
    image (image_starship, shipX, shipY);

    bulletY = bulletY - 10; //set the velocity of the bullet

    //Load the function for displaying the objects
    displayAll();
    displayAsteroid();
    starField();
    redAlert();

    //Check the timer relatd to asteroids and alien
    if (timer.finished()) { //if the timer finish to count...
      totalAliens++; //...increase the variables
      totalAsteroids++;
      counter++;
      if (totalAliens >= aliens.length) {  //if hit the end of the array...
        totalAliens = 0; //...starts again
      } 
      if (totalAsteroids >= asteroids.length) {
        totalAsteroids = 0;
      }
      timer.start(); //starting the timer again
    }

    //Check the timer related to the new life objects 
    if (timerLifeUp.finished()) {
      counter++;  
      timerLifeUp.start();
      if (totalExtra >= extraLife.length) {
        totalExtra = 0;
      } 
      timerLifeUp.start();
    }

    // Displaying the extraLife objects when the counters comes to some numebers
    if (counter == 8 || counter == 18 || counter == 28 || counter == 38 || counter == 48) {
      for (int i= 0; i < extraLife.length; i++) {
        extraLife[i].drawExtra();
      }
      catchLife(); // Check the collision
    }   

    // Keyboard controls
    if (keyPressed == true) {
      // Move up
      if (keyCode == 38 && shipY > 0) {
        shipY = shipY - 5;
      }
      // Move down
      if (keyCode == 40 && shipY > 0) {
        shipY = shipY + 5;
      }
      // Move left
      if (keyCode == 37 && shipX > 0) {
        shipX = shipX - 5;
      }
      // Move right
      if (keyCode == 39 && shipX < width) {
        shipX = shipX + 5;
      }
      // Shoot
      if (key == 'x') {
        bulletX = shipX;
        bulletY = shipY - 5;
        player3.trigger(); //trigger a sound sample
      }
    }
    //Display the text of the score
    textSize(18);
    fill(81, 245, 32);
    textAlign(LEFT, CENTER);  
    text("Score", 10, 10);
    text(score, 10, 30);
    textAlign(RIGHT, CENTER);
    text("Life", width -10, 10);
    text(life, width -10, 30);
  }
  // Win with high score
  if (score >= 15) {
    background (0);
    gameWin();
    timer.finished();
  }
  // Check if loose
  else if (deaths >= 3 && life <= 0) {
    background (0);
    gameOver();
    timer.finished();
  }
}

//---------------------------------------

// Key controls of the game
void keyPressed() { 
  if (key == ENTER) {  //start the game 
    mode = 2;
    timer.start();
    removeAllalien();
    removeAllAsteroid();
    player2.trigger();
  }
  if (key == 'r') {  //restart the game, reset all of the values
    mode = 0;
    life = 3;
    deaths = 0;
    score = 0;
    counter = 0;
    totalAliens = 0;
    totalAsteroids = 0;
    shipX = 250;
    shipY = 350;
    frameCount = 0;
    player1a.trigger(); //trigger the initial sound sample
  }
}  

//Load the functions for displaying the objects
void displayAll() {
  for (int i = 0; i < totalAliens; i++) {  
    aliens[i].moveAlien();
    aliens[i].drawAlien();
    aliens[i].reachBottom();
    checkHit(i);
    checkCollision(i);
    checkOut();
  }
}

void displayAsteroid() { //Load the function for displaying the objects
  for (int i = 0; i < totalAsteroids; i++) {
    asteroids[i].drawAsteroid();
    asteroids[i].moveAlien();
    checkAst(i);
  }
}

//Function for create an array of objects
void createAlien() { //create an array of aliens
  for (int i = 0; i < allAlien; i++) {
    aliens[i] = new Alien(0, 0, image_alien);
  }
}

void createAsteroid() { //create an array of aliens
  for (int i = 0; i < allAsteroid; i++) {
    asteroids[i] = new Asteroid(0, 0, image_asteroid);
  }
}

void createExtraPoint() { //create the elemnts for the extra life point
  for (int i=0; i<extraLife.length; i++) {
    extraLife[i] = new ExtraPoint((int)random(width), (int)random(height), image_life);
  }
}

void removeAllalien() { //removing the objects from the screen
  for (int i = 0; i < allAlien; i++) {
    removeAlien(i);
  }
}

void removeAlien(int i) { //set the position of the aliens when they go out to the screen
  aliens[i].posX = -100;
  aliens[i].posY = -100;
}

void removeAllAsteroid() { //function for removing the objects from the screen
  for (int i = 0; i < allAsteroid; i++) {
    removeAsteroid(i);
  }
}

void removeAsteroid(int i) { //set the position of the asteroids when they go out to the screen
  asteroids[i].posX = -100;
  asteroids[i].posY = -100;
}

//Check the collision between objects
void checkHit(int i) { //between aliens and bullets
  boolean insideAlien = pointInside (bulletX, bulletY, aliens[i].posX, aliens[i].posY, 
  image_alien.width, image_alien.height);

  if (insideAlien) {
    bulletY = -100;
    image(image_boom, aliens[i].posX, aliens[i].posY);
    removeAlien(i);
    score += 1;
    player5.trigger();
  }
}

void checkCollision(int i) { //between ship and aliens
  boolean insideShip = pointInside (shipX, shipY, aliens[i].posX, aliens[i].posY, 
  image_alien.width, image_alien.height);

  if (insideShip) { 
    imageMode(CENTER);
    image(image_boom2, shipX, shipY);
    shipY = height - image_starship.height+500; 
    shipX = width/2;
    life -= 1;
    deaths += 1;
    player6.trigger();
  }
}

void checkAst(int i) { //between asteroids and ship
  boolean insideAst = pointInside (shipX, shipY, asteroids[i].posX, asteroids[i].posY, 
  image_asteroid.width, image_asteroid.height);

  if (insideAst) {
    imageMode(CENTER);
    image(image_boom2, shipX, shipY);
    shipY = height - image_starship.height+500; 
    shipX = width/2;
    life -= 1;
    deaths += 1;
    player6.trigger();
  }
}

void checkOut() { //between ship and the bottom of the screen
  if (shipY > height-image_starship.height/2) {
    shipY = shipY - 20 * (int)val;
  }
}

void catchLife() { //between ship and extra life point objects
  for (int i=0; i<extraLife.length; i++) {
    extraLife[i].lifeCatch(shipX, shipY);
  }
  alert = false;
}

//Close every single sound
void stop() {
  player1.close(); 
  player1a.close(); 
  player2.close();
  player3.close();
  player5.close();
  player6.close();
  player7.close(); 

  sound_track.stop();
  sound_tracka.stop();
  sound_startplane.stop();
  sound_bullet.stop();
  sound_explAlien.stop();
  sound_explShip.stop();
  sound_catchLife.stop();

  super.stop();
}


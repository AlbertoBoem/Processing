void introScreen() {
  imageMode(CORNERS);
  tint(50, 80, 30);
  image(image_intro, 1, 1);
  fill(101, 112, 232);
  textSize(12);
  text("Good morining mr. Captain. Our Universe is again under attack!", 20, 274);
  textSize(10);
  text("Destroy more alien starships you can. Help us!", 95, 316); 
  text("But beware from the asteroids, they hit you.", 100, 330);
  text("Use the arrow keys for move your ship.", 115, 344);
  text("The ship is equipped with a powerful gun, press x for shoot.", 60, 358);
  text("Please mr. Captain, the fate of the Galactic Alliance depends on your success!", 12, 372);
}


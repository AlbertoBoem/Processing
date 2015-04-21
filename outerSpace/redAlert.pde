//Function for displaying a red alert
void redAlert() {
  if (life <= 1) {
    alert = true;  
    float alert = random(100, 250);
    noStroke();
    fill(alert, 0, 0, 55);
    rect(0, 0, width, height);
  } 
  else {
    alert = false;
  }
}


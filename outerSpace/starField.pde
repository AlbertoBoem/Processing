void starField() {
  stroke(255);
  for (int i = 0; i < 10; i++) {
    point(random(400), random(1000));
  }
  stroke(200);
  for (int i = 0; i < 15; i++) {
    point(random(300), random(1000));
  }
  stroke(155);
  for (int i = 0; i < 10; i++) {
    point(random(600), random(1000));
  }
}

//Check if a point overlap another
boolean pointInside(int pointX, int pointY, int rectX, int rectY, int rectWidth, int rectHeight) { 
  return (pointX >= rectX && pointX <= rectX + rectWidth && pointY >= rectY && pointY <= rectY + rectHeight);
}

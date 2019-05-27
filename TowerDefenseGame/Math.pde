static boolean isWhite(color c) {
  //returns if a color object is white
  return hex(c, 6).equals("FFFFFF");
}
static float distance(float x1, float y1, float x2, float y2) {
  //uses pythagorean formula to calculate distance
  return sqrt(sq(x1 - x2) + sq(y1- y2));
}
static float[] normalizeVector(float x1, float y1, float x2, float y2) {
  //normalizes a vector that goes from (x1,y1) to (x2,y2)
  float denom = distance(x1, y1, x2, y2);
  return new float[]{(x2 - x1) / denom, (y2-y1) /denom};
}
static boolean inZone(float curX, float curY, float minX, float minY, float maxX, float maxY) {
  //checks to see if a point is in a rectangle as defined by max and min X Y values
  if (curX >= minX && curX <= maxX && curY >= minY && curY <= maxY) {
    return true;
  }
  return false;
}
boolean mouseInZone(float minX, float minY, float maxX, float maxY) {
  //uses inZone and mouse position to check if the mouse is in a rectangular zone;
  return inZone(mouseX, mouseY, minX, minY, maxX, maxY);
}
boolean centerMouseInZone(float x, float y, float rectWidth, float rectHeight) {
  //another way of checking if the mouse is in a zone, except it uses a rectangle with a center and height/width
  return mouseInZone(x - rectWidth /2.0, y - rectHeight/2.0, x + rectWidth /2.0, y+ rectHeight/2.0);
}

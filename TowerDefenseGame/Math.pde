static boolean isWhite(color c) {
  return hex(c, 6).equals("FFFFFF");
}
static float distance(float x1,float y1,float x2,float y2) {
  return sqrt(sq(x1 - x2) + sq(y1- y2));
}
static float[] normalizeVector(float x1, float y1, float x2, float y2){
  float denom = distance(x1,y1,x2,y2);
  return new float[]{(x2 - x1) / denom, (y2-y1) /denom};
}

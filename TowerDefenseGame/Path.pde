class Path {
  List<int[]> coordinates;
  int[][] mapCoords =  {{0, 527}, 
    {139, 520}, 
    {230, 362}, 
    {520, 361}, 
    {522, 631}, 
    {349, 635}, 
    {354, 250}, 
    {632, 249}, 
    {637, 470}, 
    {750, 471}, 
    {753, 358}, 
    {938, 357}};
  Path() {
    coordinates = Arrays.asList(mapCoords);
  }
  List<int[]> getCoordinates() {
    return coordinates;
  }
  void display() {
    for (int x = 0; x < coordinates.size() -1; x ++) {
      strokeWeight(3);
      strokeJoin(ROUND);
      stroke(255, 0, 0);
      line(coordinates.get(x)[0], coordinates.get(x)[1], 
        coordinates.get(x + 1)[0], coordinates.get(1 + x)[1]);
      strokeWeight(1);
      stroke(0);
    }
  }
}
float distance(float x1,float y1,float x2,float y2) {
  return sqrt(sq(x1 - x2) + sq(y1- y2));
}

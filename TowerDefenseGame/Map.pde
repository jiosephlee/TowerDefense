class Map {
  //PImage zones;
  Map() {
    background = loadImage("Map1Background.PNG");
    mapZones = loadImage("Map1Zones.png");
  }
  void display() {
    image(background, 0, 0);
  }
}

boolean isWhite(color c) {
  return hex(c, 6).equals("FFFFFF");
}

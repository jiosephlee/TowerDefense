class Map {
  //PImage zones;
  Map() {
    background = loadImage("images/Map1Background.PNG");
    mapZones = loadImage("images/Map1Zones.png");
  }
  void display() {
    image(background, 0, 0);
  }
}

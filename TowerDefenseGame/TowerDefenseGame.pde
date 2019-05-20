import java.util.*;
Map m;
Menu menu; 
Path p;
PImage background;
PImage mapZones;
void setup() {
  size(1280, 720);
  background(255);
  m = new Map();
  menu = new Menu();
  p = new Path();
}
void draw() {
  background(255);
  m.display();
  menu.display();
  p.display();
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 25, 25);
  fill(0);
  textSize(36);
  text("x: " + mouseX, 50, 50); 
  text("y: " + mouseY, 50, 100); 
  textSize(20);
  text("© Boseph Bee and Biong Bhou Buang 2019", 50, 650);
  if (mousePressed) {
    System.out.println(" " + mouseX + "," + mouseY);
  }
}
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
class Menu {
  Menu() {
  }
  void display() {
    fill(255, 192, 203);
    rect(940, 0, 340, 720);
    fill(0);
    textSize(36);
    text("Menu", 1000, 50);
    color mapColor = background.get(mouseX, mouseY);
    fill(mapColor);
    rect(1000, 100, 50, 50);
    color zoneColor = mapZones.get(mouseX, mouseY);
    fill(zoneColor);
    rect(1000, 200, 50, 50);
    fill(0);
    text("Placeable: " + isWhite(zoneColor), 1000, 300);
  }
}
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
boolean isWhite(color c) {
  return hex(c, 6).equals("FFFFFF");
}

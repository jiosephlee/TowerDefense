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

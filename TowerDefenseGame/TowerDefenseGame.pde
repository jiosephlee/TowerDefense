import java.util.*;
Map m;
Menu menu; 
Path p;
LinkedList<Monster> Monsters;
ArrayList<Monster> toDestroy;
PImage background;
PImage mapZones;
Spawner s;
void setup() {
  size(1280, 720);
  background(255);
  m = new Map();
  menu = new Menu();
  p = new Path();
  Monsters = new LinkedList<Monster>();
  toDestroy = new ArrayList<Monster>();
  s = new Spawner();
}
void draw() {
  s.update();
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
  for(Monster m: Monsters){
    m.move();
  }
  for(Monster m: toDestroy){
    Monsters.remove(m);
  }
  for(Monster m: Monsters){
    m.display();
  }
  toDestroy.clear();
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
    text("HP: " + (int) (m.hp + 0.5), 600, 50); 
    color mapColor = background.get(mouseX, mouseY);
    fill(mapColor);
    rect(1000, 100, 50, 50);
    color zoneColor = mapZones.get(mouseX, mouseY);
    fill(zoneColor);
    rect(1000, 200, 50, 50);
    fill(0);
    text("Placeable: " + isWhite(zoneColor), 1000, 300);
    text("Level: " + s.level, 1000, 400);
  }
}

import java.util.*;
Map m;
Menu menu; 
Path p;
LinkedList<Monster> Monsters;
LinkedList<Projectiles> Projectiles;
ArrayList<Monster> toDestroy;
ArrayList<Projectiles> toDestroyA;
LinkedList<Towers> Towers;
PImage background,range,mapZones;
Spawner s;
void setup() {
  size(1280, 720);
  background(255);
  m = new Map();
  menu = new Menu();
  p = new Path();
  Monsters = new LinkedList<Monster>();
  toDestroy = new ArrayList<Monster>();
  toDestroyA = new ArrayList<Projectiles>();
  s = new Spawner();
  Towers = new LinkedList<Towers>();
  Projectiles = new LinkedList<Projectiles>();

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
    if(isWhite(mapZones.get(mouseX, mouseY))){
      Towers.add(new Tower1(mouseX,mouseY));
    }
  }
  for(Monster m: Monsters){
    m.move();
  }
  for(Projectiles i: Projectiles){
    i.move();
    for(Monster m: Monsters){
       if(i.x < 0 || i.x > 1280 || i.y < 0 || i.y > 720){
         toDestroyA.add(i);
         break;
       }
       if(i.dealDamage(m)){
         break;
       }
    }
  }
  for(Monster m: toDestroy){
    Monsters.remove(m);
  }
  for(Towers m: Towers){
    m.attack();
  }
  for(Projectiles i: toDestroyA){
      Projectiles.remove(i);
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
    if(isWhite(zoneColor)) { //if mousezone is valid tint the range image gray
      tint(#000000,128);
    } else{
      tint(255, 128); //if not keep it red which means invalid
    }
    imageMode(CENTER);
    range = loadImage("images/range.png"); //loads the range image
    range.resize(100,0);
    image(range, mouseX,mouseY);
    tint(255, 255);
    text("Level: " + s.level, 1000, 400);
    text("FPS: " + (int) (frameRate + 0.5), 1000, 500);
    for(Monster m: Monsters){
      m.display();
    }
    for(Towers i: Towers){
      fill(0, 0, 255);
      ellipse(i.x, i.y, 25.0, 25.0);
    }
    for(Projectiles i: Projectiles){
      System.out.println("yoo");
      fill(15, 15, 255);
      ellipse(i.x, i.y, 15.0, 15.0);
    }
  }
}

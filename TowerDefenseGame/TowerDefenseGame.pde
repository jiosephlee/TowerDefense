import java.util.*;
Map m;
Menu menu; 
Path p;
LinkedList<Monster> Monsters;
LinkedList<Projectiles> Projectiles;
ArrayList<Monster> toDestroy;
ArrayList<Projectiles> toDestroyA;
LinkedList<Towers> Towers;
PImage background, range, mapZones, play, pause;
Spawner s;
int gameMode;
boolean lastMousePressed;
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
  range = loadImage("images/range.png");
  play = loadImage("images/play.png");
  pause = loadImage("images/pause.png");
  gameMode = 0;
  lastMousePressed = false;
}
void draw() {
  s.update();
  background(255);
  m.display();
  menu.display();
  p.display();
  fill(0);
  textSize(36);
  text("x: " + mouseX, 50, 50); 
  text("y: " + mouseY, 50, 100); 
  textSize(20);
  if (gameMode == 0) {
    image(pause, 75, height - 75, 75, 75);
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, 25, 25);
    if (mousePressed && !lastMousePressed) {
      if (distance(mouseX, mouseY, 75, height - 75) < 37.5) {
        gameMode = 1;
        //pauses game if button is pressed
      }
      if (isWhite(mapZones.get(mouseX, mouseY))) {
        Towers.add(new Tower1(mouseX, mouseY));
      }
    }
    for (Monster m : Monsters) {
      m.move();
    }
    for (Projectiles i : Projectiles) {
      i.move();
      for (Monster m : Monsters) {
        if (i.x < 0 || i.x > 1280 || i.y < 0 || i.y > 720) {
          toDestroyA.add(i);
          break;
        }
        if (i.dealDamage(m)) {
          break;
        }
      }
    }
    for (Monster m : toDestroy) {
      Monsters.remove(m);
    }
    for (Towers m : Towers) {
      m.attack();
    }
    for (Projectiles i : toDestroyA) {
      Projectiles.remove(i);
    } 
    toDestroy.clear();
  } else if (gameMode == 1) {
    //when the game is paused
    image(play, 75, height - 75, 75, 75);
    //displays the play button
    if (mousePressed && !lastMousePressed && distance(mouseX, mouseY, 75, height -75) < 37.5) {
      gameMode = 0;
      //changes the gamemode and tells all the monsters to reset their time
      for(Monster m: Monsters){
        m.lastTime = System.currentTimeMillis();
      }
    }
  }
  lastMousePressed = mousePressed;
}

class Menu {
  Menu() {
  }
  void display() {
    fill(255, 192, 203);
    rect(940, 0, 340, 720);
    fill(0);
    textSize(36);
    text("HP: " + (int) (m.hp + 0.5), 600, 50); 
    color zoneColor = mapZones.get(mouseX, mouseY);
    if (isWhite(zoneColor)) { //if mousezone is valid tint the range image gray
      tint(#000000, 128);
    } else {
      tint(255, 128); //if not keep it red which means invalid
    }
    imageMode(CENTER);
    range.resize(100, 0);
    image(range, mouseX, mouseY);
    tint(255, 255);
    text("Level: " + s.level, 1000, height - 150);
    text("FPS: " + (int) (frameRate + 0.5), 1000, height - 75);
    for (Monster m : Monsters) {
      m.display();
    }
    for (Towers i : Towers) {
      fill(0, 0, 255);
      ellipse(i.x, i.y, 25.0, 25.0);
    }
    for (Projectiles i : Projectiles) {
      fill(15, 15, 255);
      ellipse(i.x, i.y, 15.0, 15.0);
    }
  }
}

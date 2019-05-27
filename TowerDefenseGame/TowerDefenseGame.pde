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
  gameMode = 2;
  lastMousePressed = false;
}
void draw() {
  textAlign(LEFT);
  textSize(36);
  rectMode(CORNER);
  updateAll();
}
void fieldSetup() {
  //sets up the tower defense field when not in the main menu
  background(255);
  m.display();
  menu.display();
  p.display();
  fill(0);
  textSize(36);
  text("x: " + mouseX, 50, 50); 
  text("y: " + mouseY, 50, 100); 
  textSize(20);
}
void updateAll(){
  if (gameMode == 0) {
    fieldSetup();
    s.update();
    image(pause, 75, height - 75, 75, 75);
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, 25, 25);
    if (mousePressed && !lastMousePressed) {
      if (distance(mouseX, mouseY, 75, height - 75) < 37.5) {
        //pauses game if button is pressed
        gameMode = 1;
        s.pause(); // pauses spawner
      }
      if (isWhite(mapZones.get(mouseX, mouseY)) && distance(mouseX, mouseY, 75, height - 75) >= 37.5) {
        if (m.money >= 10 && menu.selectedTower() == 1) {
          m.changeMoney(-10); //uses money to place tower
          Towers.add(new Tower1(mouseX, mouseY));
        }
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
    fieldSetup();
    //when the game is paused
    text("Press Play Button to Resume", 125, 650);
    image(play, 75, height - 75, 75, 75);
    //displays the play button
    if (mousePressed && !lastMousePressed && distance(mouseX, mouseY, 75, height -75) < 37.5) {
      gameMode = 0;
      s.go(); //resumes spawner
      //changes the gamemode and tells all the monsters to reset their time
      for (Monster m : Monsters) {
        m.lastTime = System.currentTimeMillis();
      }
    }
  } else if (gameMode == 3) {
    fieldSetup();
    //when the game is paused
    text("Press Play Button to Start New Level", 125, 650);
    image(play, 75, height - 75, 75, 75);
    //displays the play button
    if (mousePressed && !lastMousePressed && distance(mouseX, mouseY, 75, height -75) < 37.5) {
      gameMode = 0;
      s.resetTime(); //resumes spawner
    }
    //changes the gamemode and tells all the monsters to reset their time
    for (Monster m : Monsters) {
      m.lastTime = System.currentTimeMillis();
    }
  } else if (gameMode == 2) {
    fill(255, 178, 102);
    rectMode(CENTER);
    rect(width/2.0, height/2.0 + 150, 300, 120);  //fill in rectangle for play button
    textAlign(CENTER);

    fill(0);
    textSize(72);
    text("PLAY", width/2.0, height/2.0 + 175);
    if (mousePressed && centerMouseInZone(width/2.0, height /2.0 + 150, 300, 120)) { 
      //if play button is presed change to gameMode 0
      gameMode = 0;
      s.newLevel(); // starts new level when the play button is presed
    }
  }
  lastMousePressed = mousePressed;
}

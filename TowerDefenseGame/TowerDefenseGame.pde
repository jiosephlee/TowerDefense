import java.util.*;
//global variables for running the game
Map m;
Menu menu;
Path p;
Towers loadedTower;
ArrayList<Monster> Monsters;
LinkedList<Projectiles> Projectiles;
ArrayList<Monster> toDestroy;
ArrayList<Projectiles> toDestroyA;
ArrayList<upgradeButton> upgrades;
LinkedList<Towers> Towers;
PImage background, range, mapZones, play, pause;
Spawner s;
int gameMode;
boolean lastMousePressed, loaded, upgrading, paused;
Button[] Buttons;
Button selectedButton;
void setup() {
  //setup screen size and initial Map, Menu, and Path
  size(1280, 720);
  background(255);
  m = new Map();
  menu = new Menu();
  p = new Path();
  upgrading = false;
  Monsters = new ArrayList<Monster>(); //list of Monsters

  toDestroy = new ArrayList<Monster>(); // list of Monsters to kill after every frame
  toDestroyA = new ArrayList<Projectiles>(); //list of projectiles to destroy after every frame
  s = new Spawner(); //spawner class
  Towers = new LinkedList<Towers>(); //list of towers to display
  Projectiles = new LinkedList<Projectiles>(); // list of projectiles to display
  Buttons = new Button[]{new Button1(), new Button2()};
  upgrades = new ArrayList<upgradeButton>();
  loaded =  false;
  //load graphics of game
  range = loadImage("images/range.png");
  play = loadImage("images/play.png");
  pause = loadImage("images/pause.png");
  //set gameMode to be in main menu (2);
  gameMode = 2;
  //use lastMousePressed to debounce the mouse button
  lastMousePressed = false;
}
void draw() {
  //set up constants and call updateAll to move everything each grame
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

void updateAll() { //updates and displays game variables
  textSize(36);
  if (gameMode == 0) {
    fieldSetup(); //displays background features like map, menu etc.
    s.update(); //asks spawner to update and spawn monsters
    //display pause button
    image(pause, 75, height - 75, 75, 75);
    loadButtons();
    gameMove();
    if (mousePressed && !lastMousePressed) {
      if (distance(mouseX, mouseY, 75, height - 75) < 37.5) {
        //pauses game if button is pressed
        gameMode = 1;
        s.pause(); // pauses spawner
      }
      if (loaded && distance(mouseX, mouseY, width - 475, height - 75) < 37.5) {
        loaded = false;
      }
      checkUpgrades();
      checkButton();
    }
    movingDisplay();
  } else if (gameMode == 1) { //pause due to user
    fieldSetup();
    //when the game is paused
    text("Press Play Button to Resume", 125, 650);
    image(play, 75, height - 75, 75, 75);
    //displays the play button
    if (mousePressed && !lastMousePressed) {
      if (distance(mouseX, mouseY, 75, height -75) < 37.5) {
        gameMode = 0;
        s.go(); //resumes spawner
        //changes the gamemode and tells all the monsters to reset their time
        for (Monster m : Monsters) {
          m.lastTime = System.currentTimeMillis();
          //ask all monsters to reset time
        }
      }
    }
    movingDisplay();
  } else if (gameMode == 3) { //pause due to awaiting level to start
    fieldSetup();
    loadButtons();
    //when the game is paused
    imageMode(CENTER);
    text("Press Play Button to Start New Level", 125, 650);
    image(play, 75, height - 75, 75, 75);
    //displays the play button
    //changes the gamemode and tells all the monsters to reset their time
    for (Monster m : Monsters) {
      m.lastTime = System.currentTimeMillis();
      //ask all monsters to reset time
    }
    if (mousePressed && !lastMousePressed) {
      if (distance(mouseX, mouseY, 75, height -75) < 37.5) {
        gameMode = 0;
        s.resetTime(); //resets the time of level
      }
      checkUpgrades();
      checkButton();
    }
    movingDisplay();
  } else if (gameMode == 2) { //main menu mode
    fill(255, 178, 102);
    rectMode(CENTER);
    rect(width/2.0, height/2.0 + 150, 300, 120);  //fill in rectangle for play button
    textAlign(CENTER);
    if (mousePressed && !lastMousePressed) {
      if (centerMouseInZone(width/2.0, height /2.0 + 150, 300, 120)) {
        //if play button is presed change to gameMode 0
        gameMode = 0;
        s.newLevel(); // starts new level when the play button is presed
      }
    }
    fill(0);
    textSize(72);
    text("PLAY", width/2.0, height/2.0 + 175);
  }
  lastMousePressed = mousePressed; //debounce
}


void gameMove() {
  for (Monster m : Monsters) {
    m.move();
  }

  for (Projectiles i : Projectiles) {
    i.move();
  }
  for (Monster m : toDestroy) {
    Monsters.remove(m); //removes monsters from linkedlist after they die
  }
  for (Towers m : Towers) {
    m.attack(); //ask all towers to attack
  }
  for (Projectiles i : toDestroyA) {
    Projectiles.remove(i); //remove all projectiles awaiting removal
    i = null;
  }
  toDestroy.clear();
  toDestroyA.clear();
  //clears destruction queue
}

void movingDisplay(){
      //ask monsters to display
    for (Monster m : Monsters) {
      m.display();
    }
    //ask towers to display
    for (Towers i : Towers) {
      fill(0, 0, 255);
      ellipse(i.x, i.y, i.size, i.size);
    }
    //ask projectiles to display
    for (Projectiles i : Projectiles) {
      fill(15, 15, 255);
      ellipse(i.x, i.y, i.size, i.size);
    }
}

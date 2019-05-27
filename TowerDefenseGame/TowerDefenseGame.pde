import java.util.*;
//global variables for running the game
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
  //setup screen size and initial Map, Menu, and Path
  size(1280, 720);
  background(255);
  m = new Map();
  menu = new Menu();
  p = new Path();
  Monsters = new LinkedList<Monster>(); //list of Monsters
  toDestroy = new ArrayList<Monster>(); // list of Monsters to kill after every frame
  toDestroyA = new ArrayList<Projectiles>(); //list of projectiles to destroy after every frame
  s = new Spawner(); //spawner class
  Towers = new LinkedList<Towers>(); //list of towers to display
  Projectiles = new LinkedList<Projectiles>(); // list of projectiles to display
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
void updateAll(){
  if (gameMode == 0) {
    fieldSetup();
    s.update(); //asks spawner to update and spawn monsters
    //display pause button
    image(pause, 75, height - 75, 75, 75);
    fill(255, 0, 0);
    //display circle at mouse pointer
    ellipse(mouseX, mouseY, 25, 25);
    if (mousePressed && !lastMousePressed) {
      if (distance(mouseX, mouseY, 75, height - 75) < 37.5) {
        //pauses game if button is pressed
        gameMode = 1;
        s.pause(); // pauses spawner
      }
      //uses background image to check if the area where the mouse is at is suitable for placing a tower
      if (isWhite(mapZones.get(mouseX, mouseY)) && distance(mouseX, mouseY, 75, height - 75) >= 37.5) {
        if (m.money >= 10 && menu.selectedTower() == 1) {
          m.changeMoney(-10); //uses money to place tower
          Towers.add(new Tower1(mouseX, mouseY));
        }
      }
    }
    for (Monster m : Monsters) {
      m.move(); //ask all monsters to move
    }
    for (Projectiles i : Projectiles) {
      i.move(); //ask all projectiles to move
      for (Monster m : Monsters) {
        //adds projectiles that leave the screen to destruction queue
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
      //removes monsters from linkedlist after they die
    }
    for (Towers m : Towers) {
      //ask all towers to attack
      m.attack();
      
    }
    for (Projectiles i : toDestroyA) {
      //remove all projectiles awaiting removal
      Projectiles.remove(i);
      
    } 
    toDestroy.clear();
    //clears destruction queue
  } else if (gameMode == 1) { //pause due to user
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
        //ask all monsters to reset time
      }
    }
  } else if (gameMode == 3) { //pause due to awaiting level to start
    fieldSetup();
    //when the game is paused
    text("Press Play Button to Start New Level", 125, 650);
    image(play, 75, height - 75, 75, 75);
    //displays the play button
    if (mousePressed && !lastMousePressed && distance(mouseX, mouseY, 75, height -75) < 37.5) {
      gameMode = 0;
      s.resetTime(); //resets the time of level
    }
    //changes the gamemode and tells all the monsters to reset their time
    for (Monster m : Monsters) {
      m.lastTime = System.currentTimeMillis();
       //ask all monsters to reset time
    }
  } else if (gameMode == 2) { //main menu mode
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
  lastMousePressed = mousePressed; //debounce
}

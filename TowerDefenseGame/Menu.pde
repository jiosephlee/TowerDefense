class Menu {
  int towerNumber;
  Menu() {
  }
  void display() {
    //creates pink region on the right side of the screen for a menu
    fill(255, 192, 203);
    rect(940, 0, 340, 720);
    fill(0);
    textSize(36);
    text("HP: " + (int) (m.hp + 0.5), 600, 50);  // displays hp
    color zoneColor = mapZones.get(mouseX, mouseY);
    if (loaded) {
      if (isWhite(zoneColor)) { //if mousezone is valid tint the range image gray
        tint(#000000, 128);
      } else {
        tint(255, 128); //if not keep it red which means invalid
      }
      imageMode(CENTER);
      //sets tint of circle around mouse pointer if tower cannot be placed at mouse location
      range.resize(loadedTower.range*2, 0);
      image(range, mouseX, mouseY);
      tint(255, 255);
    }
    if (upgrading) {
      for (upgradeButton i : upgrades) {
        i.display();
      }
    }
    //display money, level and fps
    text("Money: " + m.money, 1000, height - 225);
    text("Level: " + s.level, 1000, height - 150);
    text("FPS: " + (int) (frameRate + 0.5), 1000, height - 75);
  }
}
void loadButtons() {
  fill(255, 0, 0);
  //display circle at mouse pointer
  ellipse(mouseX, mouseY, 20, 20);
  for (Button i : Buttons) { //display the buttons
    i.display();
  }
  if (loaded) {
    image(pause, 75, height - 75, 75, 75); // trash can to throw away loadedtower
  }
}
void checkButton() {

  //uses background image to check if the area where the mouse is at is suitable for placing a tower
  if (loaded && isWhite(mapZones.get(mouseX, mouseY)) && distance(mouseX, mouseY, 75, height - 75) >= 37.5) { //if user places tower, place it and replace the button's loaded tower with a new one, and tell the map no tower is selected now
    if (m.money >= loadedTower.price) {
      m.changeMoney(-1 * loadedTower.price); //uses money to place tower
      loadedTower.setxy(mouseX, mouseY);
      Towers.add(loadedTower);
      selectedButton.newTower();
      loaded = false;
      upgrades.add(new upgradeButton(loadedTower));
      upgrading = false;
    }
  } else {// if they press the button tell map that it's been clicked and load the selected tower
    for ( Button b : Buttons) {
      if (get(mouseX, mouseY) == b.Color) {
        selectedButton = b; //load button that's been clicked so it can be reset with a new object later on
        loaded = true; 
        loadedTower = b.load; //take the tower from the button and load it to map
        break;
      }
    }
  }
}

abstract class Button {
  float x, y;
  color Color;
  Towers load;
  Button(float xA, float yA, Towers loaded, color a) {
    Color = a;
    x = xA;
    y = yA;
    load = loaded;
  }
  abstract void newTower();
  void display() {
    fill(Color);
    rect(x, y, 40, 40);
    fill(0);
    textSize(12);
    text((load.getClass().getName() + "").substring(17, 23), x - 50, y + 20);
  }
}


class Button1 extends Button {
  Button1() {
    super(1020, 200, new Tower1(-1, -1), color(103, 207, 45));
  }
  void newTower() {
    load = new Tower1(-1, -1);
  }
}

class Button2 extends Button {
  Button2() {
    super(1200, 200, new Tower2(-1, -1), color(173, 107, 245));
  }
  void newTower() {
    load = new Tower2(-1, -1);
  }
}

class upgradeButton {
  Towers me;
  int size;
  boolean display;
  upgradeButton(Towers hi) {
    me = hi;
    size = me.size/3 * 2;
    display = false;
  }
  void checkInitiated() {
    if (distance(mouseX, mouseY, me.x, me.y) <= me.size) {
      upgrading = true;
      display = true;
    }
  }
  void checkClicked() {
    if (!me.onemaxed && distance(mouseX, mouseY, me.x-50, me.y-30) <= size) {
      me.upgradeFirst();
      upgrading = false;
      display = false;
    } else if (!me.twomaxed && distance(mouseX, mouseY, me.x+50, me.y-30) <= size) {
      me.upgradeSecond();
      upgrading = false;
      display = false;
    } else if (distance(mouseX, mouseY, me.x, me.y) <= me.size) {
      upgrading = false;
      display = false;
    }
  }
  void display() {
    if (display) {
      tint(#000000, 128);
      imageMode(CENTER);
      //sets tint of circle around chosen tower
      range.resize(me.range*2, 0);
      image(range, me.x, me.y);
      tint(255, 255);

      if (me.onemaxed) {
        fill(0, 0, 0);
      } else {
        fill(175, 34, 103);
      }
      ellipse(me.x-50, me.y-30, size, size);
      if (me.twomaxed) {
        fill(0, 0, 0);
      } else {
        fill(195, 134, 63);
      }
      ellipse(me.x+50, me.y-30, size, size);
    }
  }
}

void checkUpgrades() {
  if (upgrading) {
    for (upgradeButton i : upgrades) {
      i.checkClicked();
    }
  } else {
    for (upgradeButton i : upgrades) {
      i.checkInitiated();
    }
  }
}
/*void loadMainMenu() {
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
 */
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
  color zoneColor = mapZones.get(mouseX, mouseY);
  if (loaded) {
    if (isWhite(zoneColor)) { //if mousezone is valid tint the range image gray
      fill(101, 127);
    } else {
      fill(255, 0, 0, 127);
    }
    //places a transparent circle around mouse pointer showing whether tower cannot be placed at mouse location
    ellipse(mouseX, mouseY, loadedTower.range*2, loadedTower.range*2);
  }
  if (upgrading) {
    print("hi");
    for (Towers j : Towers) {
      j.upgrade.display();
    }
  }
  if (loaded) {
    image(trash, width - 475, height - 75, 75, 75); // trash can to throw away loadedtower
  }
}
void checkButton() {

  //uses background image to check if the area where the mouse is at is suitable for placing a tower
  if (loaded && isWhite(mapZones.get(mouseX, mouseY)) && distance(mouseX, mouseY, 75, height - 75) >= 37.5) { //if user places tower, place it and replace the button's loaded tower with a new one, and tell the map no tower is selected now
    if (m.changeMoney(-1 * loadedTower.price)) { //uses money to place tower
      loadedTower.setxy(mouseX, mouseY);
      Towers.add(loadedTower);
      selectedButton.newTower();
      loaded = false;
      upgrading = false;
    }
  } else {// if they press the button tell map that it's been clicked and load the selected tower
    for ( Button b : Buttons) {
      if (get(mouseX, mouseY) == b.Color) {
        selectedButton = b; //load button that's been clicked so it can be reset with a new object later on
        loaded = true; 
        upgrading = false;
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
  void notDisplay() {
    display = false;
  }
  void checkInitiated() {
    if (distance(mouseX, mouseY, me.x, me.y) <= me.size) {
      for (Towers i : Towers) {
        i.upgrade.notDisplay();
      }
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
    } else if (distance(mouseX, mouseY, me.x, me.y + 40) <= 15) {
      upgrading = false;
      display = false;
      Towers.remove(me);
    } else if (distance(mouseX, mouseY, me.x, me.y) <= me.size) {
      upgrading = false;
      display = false;
    }
  }
  void display() {
    if (display) {
      //sets range around chosen tower
      fill(101, 127);
      ellipse(me.x, me.y, loadedTower.range*2, loadedTower.range*2);

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
      image(trash, me.x, me.y + 50, 30, 30); // trash can to sell tower
    }
  }
}

void checkUpgrades() {
  if (upgrading) {
    for (Towers i : Towers) {
        i.upgrade.checkClicked();
    }
  } else {
    for (Towers i : Towers) {
      i.upgrade.checkInitiated();
    }
  }
}

void checkHover() {
  if (!loaded) {
    for (Button i : Buttons) {
      if (mouseInZone(i.x, i.y, i.x + 40, i.y +40)) {
        if (i.x < 1100) {
          image(textbubble, i.x + 45, i.y - 80, 200, 120);
          textSize(24);
          fill(255, 255, 255);
          text("IntroCS Student", i.x - 47.5, i.y - 107.5);
          textSize(12);
          text("Tower that shoots bullets \nstraight at the monsters", i.x - 47.5, i.y - 87.5);
        } else {
          image(textbubble2, i.x - 32.5, i.y - 80, 200, 120);
          textSize(24);
          fill(255, 255, 255);
          text("AP CS Student", i.x - 125, i.y - 110);
          textSize(12);
          text("Tower that shoots bullets \nthat follow untargeted \nmonsters", i.x - 125, i.y - 90);
        }
      }
    }
    if (upgrading) {
      for (Towers i : Towers) {
          if (distance(mouseX, mouseY, i.x-50, i.y-30) <= i.size && !i.onemaxed) {
            image(textbubble, i.x - 10, i.y - 120, 200, 140);
            i.displayFirstUpgradeText();
          }
          if (distance(mouseX, mouseY, i.x+50, i.y-30) <= i.size && !i.twomaxed) {
            image(textbubble2, i.x + 12.5, i.y - 120, 200, 140);
            i.displaySecondUpgradeText();
          }
        
      }
    }
  }
}

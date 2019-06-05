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
    //ask monsters to display
    for (Monster m : Monsters) {
      m.display();
    }
    //ask towers to display
    for (Towers i : Towers) {
      i.display();
    }
    //ask projectiles to display
    for (Projectiles i : Projectiles) {
      i.display();
    }
  }
}

void loadButtons() { //loads all the buttons on the side menu and upgrade buttons
  fill(255, 0, 0);
  //display circle at mouse pointer
  ellipse(mouseX, mouseY, 20, 20);
  for (Button i : Buttons) { //display the buttons
    i.display();
  }
  color zoneColor = mapZones.get(mouseX, mouseY);
  if (loaded) { //if user selected a button
    if (isWhite(zoneColor)) { //if mousezone is valid tint the range image gray
      fill(101, 127);
    } else { //else show red range
      fill(255, 0, 0, 127);
    }
    ellipse(mouseX, mouseY, loadedTower.range*2, loadedTower.range*2); //places a transparent circle around mouse pointer showing whether tower cannot be placed at mouse location
    image(trash, width - 475, height - 75, 75, 75); // trash can to throw away loadedtower
  }
  if (upgrading) { //if user wants to upgrade, load the tower buttons for that tower
    for (Towers j : Towers) {
      j.upgrade.display();
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
    text((load.getClass().getName() + "").substring(17, 28), x - 75, y + 20);
  }
}


class Button1 extends Button {
  Button1() {
    super(1020, 200, new BasiccTower(-1, -1), color(103, 207, 45));
  }
  void newTower() {
    load = new BasiccTower(-1, -1);
  }
}

class Button2 extends Button {
  Button2() {
    super(1200, 200, new FollowTower(-1, -1), color(173, 107, 245));
  }
  void newTower() {
    load = new FollowTower(-1, -1);
  }
}

class Button3 extends Button {
  Button3() {
    super(1020, 350, new MortarTower(-1, -1), color(213, 324, 23));
  }
  void newTower() {
    load = new MortarTower(-1, -1);
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
  void yesDisplay() {
    display = true;
  }
  void display() {
    if (display) {
      //sets range around chosen tower
      fill(101, 127);
      ellipse(me.x, me.y, me.range*2, me.range*2);

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

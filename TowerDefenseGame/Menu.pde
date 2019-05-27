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
      range.resize(100, 0);
      image(range, mouseX, mouseY);
      tint(255, 255);
    }
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
      fill(0, 0, 255);
      ellipse(i.x, i.y, 25.0, 25.0);
    }
    //ask projectiles to display
    for (Projectiles i : Projectiles) {
      fill(15, 15, 255);
      ellipse(i.x, i.y, 15.0, 15.0);
    }
  }
}

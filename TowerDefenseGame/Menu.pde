class Menu {
  int towerNumber;
  Menu() {
    towerNumber = 1;
  }
  int selectedTower(){
    return towerNumber;
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
    text("Money: " + m.money, 1000, height - 225);
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

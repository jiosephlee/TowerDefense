abstract class Monster {
  String[] imageFiles;
  float size;
  float speed;
  float hp;
  Monster children;
  int childrenNumber;
  boolean armored;
  float x;
  Path p;
  float y;
  abstract void spawn();
  abstract void move();
  abstract void display();
  abstract double changeHP(double changeHP);
}
class Slime extends Monster {
  Slime(Path p) {
    this.p = p;
    size = 20;
    speed = 5;
    hp = 10;
    children = null;
    childrenNumber = 0;
    armored = false;
    x = 0;
    y = 0;
    imageFiles = null;
    spawn();
  }
  void display() {
    fill(0, 0, 255);
    ellipse(x, y, 25.0, 25.0);
  }
  void spawn() {
    x = p.getCoordinates().get(0)[0];
    x = p.getCoordinates().get(0)[1];
    display();
  }
  void move() {
    display();
  }
  double changeHP(double change) {
    hp += change;
    return hp;
  }
}

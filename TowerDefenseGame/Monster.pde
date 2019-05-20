abstract class Monster {
  String[] imageFiles;
  float size;
  float speed;
  float hp;
  Monster children;
  int childrenNumber;
  float damage;
  boolean armored;
  float x;
  Path p;
  float y;
  int pathNode;
  abstract void spawn();
  abstract void move();
  abstract void display();
  abstract double changeHP(double changeHP);
  abstract void dealDamage();
}
class Slime extends Monster {
  Slime(Path p) {
    damage = 1;
    this.p = p;
    size = 20;
    speed = 1;
    hp = 10;
    children = null;
    childrenNumber = 0;
    armored = false;
    x = 0;
    y = 0;
    imageFiles = null;
    pathNode =0;
    spawn();
  }
  void display() {
    fill(0, 0, 255);
    ellipse(x, y, 25.0, 25.0);
  }
  void spawn() {
    x = p.getCoordinates().get(0)[0];
    y = p.getCoordinates().get(0)[1];
    display();
  }
  void move() {
    display();
    float nextNodeX = p.getCoordinates().get(pathNode + 1)[0];
    float nextNodeY = p.getCoordinates().get(pathNode + 1)[1];
    if (distance(x, y, nextNodeX, nextNodeY) < speed && pathNode < speed) {
      if (pathNode < p.getCoordinates().size() -1) {
        x = nextNodeX;
        y = nextNodeY;
        pathNode++;
      } else {
        dealDamage();
      }
    }
    float[] movement = normalizeVector(x, y, nextNodeX, nextNodeY);
    x +=  5 * movement[0];
    y += 5 * movement[1];
  }
  void dealDamage() {
  }
  double changeHP(double change) {
    hp += change;
    return hp;
  }
}

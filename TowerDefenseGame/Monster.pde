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
  boolean justReachedNode;
  abstract void spawn();
  abstract void move();
  abstract void display();
  abstract double changeHP(double changeHP);
  abstract void dealDamage();
  abstract void die();
}
class Slime extends Monster {
  Slime(Path p) {
    damage = 1;
    this.p = p;
    size = 20;
    speed = 4;
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
    if (distance(x, y, nextNodeX, nextNodeY) < speed && !justReachedNode) {
      justReachedNode = true;
      if (pathNode < p.getCoordinates().size() -2) {
        x = nextNodeX;
        y = nextNodeY;
        pathNode++;
      } else {
        dealDamage();
        
      }
    } else {
      justReachedNode = false;
    }
    nextNodeX = p.getCoordinates().get(pathNode + 1)[0];
    nextNodeY = p.getCoordinates().get(pathNode + 1)[1];
    float[] movement = normalizeVector(x, y, nextNodeX, nextNodeY);
    x +=  speed * movement[0];
    y += speed * movement[1];
  }
  void dealDamage() {
  }
  double changeHP(double change) {
    hp += change;
    return hp;
  }
  void die(){
    
  }
}

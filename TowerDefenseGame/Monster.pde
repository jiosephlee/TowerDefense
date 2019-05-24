abstract class Monster {
  PImage imageFile;
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
  long lastTime;
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
    speed = 1;
    hp = 10;
    children = null;
    childrenNumber = 0;
    armored = false;
    x = 0;
    y = 0;
    imageFile = loadImage("images/Slimes.png");
    pathNode =0;
    spawn();
    lastTime = System.currentTimeMillis();
  }
  Slime(Path p, float x, float y){
    this(p);
    this.x = x;
    this.y = y;
  }
  void display() {
    imageMode(CENTER);
    image(imageFile,x,y,50,40);
  }
  void spawn() {
    x = p.getCoordinates().get(0)[0];
    y = p.getCoordinates().get(0)[1];
    display();
  }
  void move() {
    //display();
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
    long deltaTime = System.currentTimeMillis() - lastTime;
    x +=  deltaTime * speed * movement[0] / 15.0;
    y += deltaTime * speed * movement[1] / 15.0;
    lastTime = System.currentTimeMillis();
    println(deltaTime);
  }
  void dealDamage() {
    m.changeHP(damage);
    die();
  }
  double changeHP(double change) {
    hp += change;
    if(hp < 0){
      this.die();
    }
    return hp;
  }
  void die(){
    toDestroy.add(this);
  }
}

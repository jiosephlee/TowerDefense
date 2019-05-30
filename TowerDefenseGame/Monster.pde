abstract class Monster {
  //characterististics of a monster
  PImage imageFile;
  float size;
  float speed;
  float hp;
  int childrenNumber; //children spawned if it is killed
  float damage; //damage done when it reaches end of map
  boolean armored; //resistance to certain attacks
  float x; //x coordinate
  Path p; //path it is following
  float y; //y coord
  int pathNode; //what node of the path it has reached
  boolean justReachedNode; //has it just reached the node in the last frame
  long lastTime; //monster's time at last frame
  float nextNodeX, nextNodeY; //node of path that monster is trying to reach
  float distanceTraveled;
  abstract void spawn(); 
  abstract void move();
  abstract void display();
  abstract double changeHP(double changeHP);
  abstract void dealDamage(); //deal damage to map when it hits the end
  abstract void die();
  abstract float[] calculateNewPosition(long deltaTime);
  abstract float distanceTraveled(); // distance travelled by the mosnter since the start of hte level
}
class Slime extends Monster {
  Slime(Path p) {
    //basic slime stats
    //constructor for basic spawning by spawner
    damage = 1;
    this.p = p;
    size = 10;
    speed = 1;
    hp = 10;
    childrenNumber = 0;
    armored = false;
    x = 0;
    y = 0;
    imageFile = loadImage("images/Slimes.png"); //load image
    pathNode =0;
    spawn();
    lastTime = System.currentTimeMillis();
  }
  Slime(Path p, float x, float y, int pathNode) {
    //alternate constructor that is useful for creating a basic slime when a higher level slime dies
    this(p);
    this.pathNode = pathNode;
    this.x = x;
    this.y = y;
  }
  void display() { //displays slime
    imageMode(CENTER);
    image(imageFile, x, y, 5 * size, 4 * size);
  }
  void spawn() { //spawns slime at the start of the path
    x = p.getCoordinates().get(0)[0];
    y = p.getCoordinates().get(0)[1];
  }
  float distanceTraveled(){
    return distanceTraveled;
  }
  void move() {
    //display();
    nextNodeX = p.getCoordinates().get(pathNode + 1)[0];
    nextNodeY = p.getCoordinates().get(pathNode + 1)[1];
    //gets the coordinates of where the slime is trying to reach
    if (distance(x, y, nextNodeX, nextNodeY) < speed && !justReachedNode) {
      justReachedNode = true;
      //if it has reached a node, set its goal node to the next one
      if (pathNode < p.getCoordinates().size() -2) {
        x = nextNodeX;
        y = nextNodeY;
        pathNode++;
      } else {
        //if it has reached the end, deal damage
        dealDamage();
      }
    } else {
      justReachedNode = false;
    }
    //sets time since last frame, used to peg the slime's movement to time
    long deltaTime = System.currentTimeMillis() - lastTime;
    float[] newPost = calculateNewPosition(deltaTime);
    //uses change in time to calculate new position and moves slime there
    x = newPost[0];
    y = newPost[1];
    distanceTraveled += (speed * deltaTime);
  }
  float[] calculateNewPosition(long deltaTime) {
    //takes that that has elapsed to calculte a new positoin for the slime
    float[] ret = new float[2];
    nextNodeX = p.getCoordinates().get(pathNode + 1)[0];
    nextNodeY = p.getCoordinates().get(pathNode + 1)[1];
    float[] movement = normalizeVector(x, y, nextNodeX, nextNodeY);
    //uses normalize vector to get direction it is moving and mutiply by speed and time elapsed
    ret[0] = x+ deltaTime * speed * movement[0] / 15.0;
    ret[1] = y + deltaTime * speed * movement[1] / 15.0;
    lastTime = System.currentTimeMillis();
    return ret;
  }
  void dealDamage() {
    //deals damage to the map itself
    m.changeHP(damage);
    die();
  }
  double changeHP(double change) {
    //changes hp, is used when a projectile attacks slime
    //gives the user money if its hp is below 0 and dies
    hp += change;
    if (hp <= 0) {
      this.die();
      m.changeMoney(1);
    }
    return hp;
  }
  void die() {
    toDestroy.add(this);
  }
}
class RedSlime extends Slime{
  //a stronger slime
  RedSlime(Path p){
    //better stats, spawns chldren when it dies
    super(p);
    size = 15;
    speed = 1.5;
    hp = 15;
    childrenNumber = 2;
    damage = 5;
  }
  void dealDamage(){
    //deals damage to the map
    m.changeHP(damage);
    toDestroy.add(this);
  }
  void die(){
    //dies but also spawns two new slimes at position
    toDestroy.add(this);
    m.changeMoney(2);
    for(int i = 0; i < childrenNumber; i++){
      float[] newPos = calculateNewPosition(-50+ i * 100);
      Monsters.add(new Slime(p,newPos[0],newPos[1], pathNode));
    }
  }
}
class Mushroom extends Slime{
  //a fast and weak monster
  Mushroom(Path p){
    //better stats, spawns chldren when it dies
    super(p);
    size = 8;
    speed = 2.25;
    hp = 5;
    damage = 5;
    imageFile = loadImage("images/Mushroom.png");
  }
}
class Tank extends RedSlime{
  Tank(Path p){
    super(p);
    size = 20;
    speed = 0.5;
    hp = 40;
    childrenNumber = 6;
    damage = 10;
    imageFile = loadImage("images/Tank.png");
  }
  void display() { //displays slime
    image(imageFile, x, y, 4 * size, 5 * size);
  }
}

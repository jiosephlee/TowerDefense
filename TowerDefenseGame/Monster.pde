abstract class Monster{
  String[] imageFiles;
  double size;
  double speed;
  double hp;
  Monster children;
  int childrenNumber;
  boolean armored;
  double x;
  double y;
  abstract void move();
  abstract void display();
  abstract double changeHP();
}
class Slime extends Monster{
  Slime(int x, int y){
    size = 20;
    speed = 5
    hp = 10;
    children = null;
    childrenNumber = 0;
    armored = false;
    this.x = x;
    this.y = y;
    imageFiles = null;
  }
  void move(Path p){
  
  }
  
}

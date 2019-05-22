abstract class Towers {
  float x, y, size, range, firerate, damage;
  int firstPathLevel, secondPathLevel;
  
  Towers(float xA, float yA, float sizeA, float rangeA, float firerateA, float damageA) {
    x = xA;
    y = yA;
    size = sizeA;
    range = rangeA;
    firerate = firerateA;
    damage = damageA;
  }

  abstract boolean attack(Monster i);
}

class Tower1 extends Towers {

  Tower1(float xA, float yA) {
    super(xA, yA, 30, 10000000, 1, 5);
  }

  boolean attack(Monster i) {
      if(Math.pow(i.x - x,2) + Math.pow(i.y - y,2) <= Math.pow(range,2)){
        return true;
      }
    return false;
  }
 
}

abstract class Towers {
  float x, y, size, range, firerate, damage,shotTime;
  int firstPathLevel, secondPathLevel;
  boolean resting;


  Towers(float xA, float yA, float sizeA, float rangeA, float firerateA, float damageA) {
    x = xA;
    y = yA;
    size = sizeA;
    range = rangeA;
    firerate = firerateA;
    damage = damageA;
  }

  abstract void attack(LinkedList<Monster> Monsters);
}

class Tower1 extends Towers {

  Tower1(float xA, float yA) {
    super(xA, yA, 30, 70, 1, 5);
  }

  void attack(LinkedList<Monster> Monsters) {
    if((millis() - shotTime)/1000 >= firerate){
        resting = false;
    }
    if (resting){
        for (Monster i : Monsters) {
            if(Math.pow(i.x - x,2) + Math.pow(i.y - y,2) <= Math.pow(range,2)){
                i.changeHP(-1* damage);
                resting = true;
                shotTime = millis();
            }
        }
    }
}

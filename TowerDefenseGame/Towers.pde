abstract class Towers {
  float x, y, size, range, fireRate, damage,shotTime;
  int firstPathLevel, secondPathLevel;
  boolean resting;


  Towers(float xA, float yA, float sizeA, float rangeA, float fireRateA, float damageA) {
    x = xA;
    y = yA;
    size = sizeA;
    range = rangeA;
    fireRate = fireRateA;
    damage = damageA;
  }

  abstract void attack(LinkedList<Monster> Monsters);
}

class Tower1 extends Towers {

  Tower1(float xA, float yA) {
    super(xA, yA, 30, 70, 1, 5);
  }

  void attack(LinkedList<Monster> Monsters) {
    if(resting && (millis() - shotTime)/1000 >= fireRate){
        
        resting = false;
    }
    if (!resting){
        for (Monster i : Monsters) {
            if(Math.pow(i.x - x,2) + Math.pow(i.y - y,2) <= Math.pow(range,2)){
                System.out.println("yo");
                i.changeHP(-1 * damage);
                resting = true;
                shotTime = millis();
                return;
            }
        }
    }
  }

}

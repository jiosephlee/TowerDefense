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

  abstract void attack();
}

class Tower1 extends Towers {

  Tower1(float xA, float yA) {
    super(xA, yA, 30, 100, 1, 5);
  }

  void attack() {
    if(resting && (millis() - shotTime)/1000 >= fireRate){     //if more than the time that firerate dictates has passed, then it shoots again
        resting = false;
    }
    if (!resting){
        for (Monster i : Monsters) {
            if(Math.pow(i.x - x,2) + Math.pow(i.y - y,2) <= Math.pow(range,2)){ //if monster if is in range of the tower, then shoot a projectile at it and mark the time it shot for firerate checking
                Projectiles.add(new StraightBullet(x,y,i,damage));
                resting = true;
                shotTime = millis();
                return;
            }
        }
    }
  }

}

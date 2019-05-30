abstract class Towers {
  float x, y, fireRate, damage, shotTime;
  int firstPathLevel, secondPathLevel, range, price, size, penetrationLvl, speedChange;
  boolean resting;


  Towers(float xA, float yA, int sizeA, int rangeA, float fireRateA, float damageA) {
    x = xA;
    y = yA;
    size = sizeA;
    range = rangeA;
    fireRate = fireRateA;
    damage = damageA;
    firstPathLevel = 0;
    secondPathLevel = 0;
    penetrationLvl = 1;
  }

  abstract void attack();
  abstract void upgradeFirst();
  abstract void upgradeSecond();
  
  void setxy(float xA, float yA) {
    x = xA; 
    y = yA;
  }
}

class Tower1 extends Towers {
  
int bulletSpread;
  Tower1(float xA, float yA) {
    super(xA, yA, 20, 100, 1, 5);
    price = 10;
    bulletSpread = 1;
  }



  void attack() {
    if (resting && (millis() - shotTime)/1000 >= fireRate) {     //if more than the time that firerate dictates has passed, then it shoots again
      resting = false;
    }
    if (!resting) {
      for (Monster i : Monsters) {
        if (Math.pow(i.x - x, 2) + Math.pow(i.y - y, 2) <= Math.pow(range, 2)) { //if monster if is in range of the tower, then shoot a projectile at it and mark the time it shot for firerate checking
          Projectiles.add(new StraightBullet(x, y, i, damage, size, penetrationLvl));
          resting = true;
          shotTime = millis();
          return;
        }
      }
    }
  }

  void upgradeFirst() {
    if (firstPathLevel == 0) {
      size+=10;
      penetrationLvl++;
    } else if(firstPathLevel == 1){
      damage+=10;
    } else{
      speed
      penetrationLvl++;
      damage+=5;
    }
  }

  void upgradeSecond() {
    if (secondPathLevel == 0) {
      fireRate = fireRate/2;
    } else {
      bulletSpread = 3;
    }
  }
}

class Tower2 extends Towers {
int bulletBeat;
  Tower2(float xA, float yA) {
    super(xA, yA, 20, 100, 1, 5);
    price = 20;
    bulletBeat=1;
  }

  void attack() {
    if (resting && (millis() - shotTime)/1000 >= fireRate) {     //if more than the time that firerate dictates has passed, then it shoots again
      resting = false;
    }
    if (!resting) {
      for (Monster i : Monsters) {
        if (Math.pow(i.x - x, 2) + Math.pow(i.y - y, 2) <= Math.pow(range, 2)) { //if monster if is in range of the tower, then shoot a projectile at it and mark the time it shot for firerate checking
          Projectiles.add(new followBullet(x, y, i, damage, size, penetrationLvl));
          resting = true;
          shotTime = millis();
          return;
        }
      }
    }
  }
  void upgradeFirst() {
    if (firstPathLevel == 0) {
      size+=10;
    } else {
      damage+=20;
    }
  }

  void upgradeSecond() {
    if (secondPathLevel == 0) {
      fireRate = fireRate/2;
    } else {
      bulletBeat = 2;
    }
  }
}

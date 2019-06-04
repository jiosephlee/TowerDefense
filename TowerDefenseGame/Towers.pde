abstract class Towers {
  float x, y, fireRate, damage;
  long shotTime;
  int firstPathLevel, secondPathLevel, range, price, size, penetrationLvl, speedChange;
  boolean resting, onemaxed, twomaxed;


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
    speedChange = 0;
    onemaxed = false;
    twomaxed = false;
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
    super(xA, yA, 40, 100, 1, 5);
    price = 10;
    bulletSpread = 1;
  }



  void attack() {
    if (resting && (millis() - shotTime)/1000 >= fireRate) {     //if more than the time that firerate dictates has passed, then it shoots again
      resting = false;
    }
    if (!resting) {
      for (Monster i : Monsters) {
        if (distance(i.x, i.y, x, y) <= range) { //if monster if is in range of the tower, then shoot a projectile at it and mark the time it shot for firerate checking
          Projectiles.add(new StraightBullet(x, y, i, damage, size, penetrationLvl, speedChange));
          resting = true;
          shotTime = millis();
          return;
        }
      }
    }
  }

  void upgradeFirst() {
    if (m.changeMoney(-(1 + firstPathLevel) * 5)) {
      if (firstPathLevel == 0) {
        size+=10;
        penetrationLvl++;
      } else if (firstPathLevel == 1) {
        damage+=10;
        twomaxed = true;
      } else if (firstPathLevel == 2) {
        speedChange--;
        penetrationLvl++;
        damage+=5;
        onemaxed = true;
      }
      firstPathLevel++;
    }
  }

  void upgradeSecond() {
    if (secondPathLevel == 0) {
      fireRate = fireRate/2;
      m.changeMoney(-1 * 5);
      secondPathLevel++;
    } else if (secondPathLevel ==1) {
      speedChange++;
      damage+=5;
      m.changeMoney(-1 * 5);
      secondPathLevel++;
      onemaxed = true;
    } else if (secondPathLevel == 2) {
      bulletSpread = 3;
      m.changeMoney(-1 * 10);
      secondPathLevel++;
      twomaxed = true;
    }
  }
}

class Tower2 extends Towers {
  int bulletBeat;
  Tower2(float xA, float yA) {
    super(xA, yA, 40, 100, 1, 5);
    price = 20;
    bulletBeat=1;
  }
  void attack() {
    if (resting && (millis() - shotTime)/1000 >= fireRate) {     //if more than the time that firerate dictates has passed, then it shoots again
      resting = false;
    }
    if (!resting) {
      for (Monster i : Monsters) {
        if (distance(i.x, i.y, x, y) <= range) { //if monster if is in range of the tower, then shoot a projectile at it and mark the time it shot for firerate checking
          Projectiles.add(new followBullet(x, y, i, damage, size, penetrationLvl, speedChange));
          resting = true;
          shotTime = millis();
          return;
        }
      }
    }
  }
  void upgradeFirst() {
    if (m.changeMoney(-(1 + firstPathLevel) * 5)) {
      if (firstPathLevel == 0) {
        size+=10;
        speedChange--;
        penetrationLvl++;
        twomaxed = true;
      } else if (firstPathLevel == 1) {
        damage+=20;
        penetrationLvl++;
        speedChange--;
        onemaxed = true;
      }
      firstPathLevel++;
    }
  }

  void upgradeSecond() {
    if (secondPathLevel < 3) {
      if (m.changeMoney(-(1 + secondPathLevel) * 5)) {
        if (secondPathLevel == 0) {
          fireRate = fireRate/2;
          speedChange++;
          onemaxed = true;
        } else if (secondPathLevel == 1) {
          speedChange++;
          bulletBeat = 2;
          twomaxed = true;
        }
        secondPathLevel++;
      }
    }
  }
}
class MortarTower extends Towers {
  float blastRadius;
  MortarTower(float xA, float yA) {
    super(xA, yA, 40, 600, 2.0, 10);
    blastRadius = 75;
    price = 40;
  }
  void attack() {
    //println((millis() - shotTime)/1000.0);
    if ((millis() - shotTime)/1000.0 >= fireRate && Monsters.size() > 0) {     //if more than the time that firerate dictates has passed, then it shoots again
      Projectiles.add(new MortarShell(x, y, Monsters.get(0), damage, blastRadius));
      shotTime = millis();  
  }
    
  }

  void upgradeFirst() {
  }
  void upgradeSecond() {
  }
}

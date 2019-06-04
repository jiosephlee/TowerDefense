abstract class Towers {
  float x, y, fireRate, damage, shotTime;
  int firstPathLevel, secondPathLevel, range, price, size, penetrationLvl, speedChange;
  boolean resting, onemaxed, twomaxed;
  upgradeButton upgrade;


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
    upgrade = new upgradeButton(this);
  }

  abstract void attack();
  abstract void upgradeFirst();
  abstract void upgradeSecond();
  abstract void displayFirstUpgradeText();
  abstract void displaySecondUpgradeText();

  void setxy(float xA, float yA) {
    x = xA; 
    y = yA;
  }
    void checkInitiated() {
    if (distance(mouseX, mouseY, x, y) <= size) {
      for (Towers i : Towers) {
        i.upgrade.notDisplay();
      }
      upgrading = true;
      upgrade.yesDisplay();
    }
  }
  void checkClicked() {
    if (!me.onemaxed && distance(mouseX, mouseY, me.x-50, me.y-30) <= size) {
      me.upgradeFirst();
      upgrading = false;
      display = false;
    } else if (!me.twomaxed && distance(mouseX, mouseY, me.x+50, me.y-30) <= size) {
      me.upgradeSecond();
      upgrading = false;
      display = false;
    } else if (distance(mouseX, mouseY, me.x, me.y + 40) <= 15) {
      upgrading = false;
      display = false;
      Towers.remove(me);
    } else if (distance(mouseX, mouseY, me.x, me.y) <= me.size) {
      upgrading = false;
      display = false;
    }
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
    if (m.changeMoney(-(1 + firstPathLevel) * 5)) {
      if (secondPathLevel == 0) {
        fireRate = fireRate/2;
      } else if (secondPathLevel ==1) {
        speedChange++;
        damage+=5;
        onemaxed = true;
      } else if (secondPathLevel == 2) {
        bulletSpread = 3;
        twomaxed = true;
      }
      secondPathLevel++;
    }
  }
  void displayFirstUpgradeText() {
    fill(255, 255, 255);
    if (firstPathLevel == 0) {
      textSize(16);
      text("Level 1", x - 104.5, y - 165);
      textSize(12);
      text("Increase penetration level to 2. If \nmonster doesn't die immediately \nbullet won't go through, however", x - 104.5, y - 145);
    } else if (firstPathLevel == 1) {
      textSize(16);
      text("Level 2", x - 100, y - 165);
      textSize(12);
      text("Increase damage rate by 10", x - 100, y - 145);
    } else if (firstPathLevel == 2) {
      textSize(16);
      text("Level 3", x - 100, y - 165);
      textSize(12);
      text("Increase penetration level \nto 3 and damage rate by 5 \nbut decrease bullet speed", x - 100, y - 145);
    }
  }

  void displaySecondUpgradeText() {
    fill(255, 255, 255);
    if (secondPathLevel == 0) {
      textSize(16);
      text("Level 1", x - 80, y - 165);
      textSize(12);
      text("Double firerate by 2", x - 80, y - 145);
    } else if (secondPathLevel == 1) {
      textSize(16);
      text("Level 2", x - 80, y - 165);
      textSize(12);
      text("Increase bullet speed and \ndamage rate by 5", x - 80, y - 145);
    } else if (secondPathLevel == 2) {
      textSize(16);
      text("Level 3", x - 80, y - 165);
      textSize(12);
      text("Shoots a spread of 3 bullets", x - 80, y - 145);
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
  void displayFirstUpgradeText() {
    fill(255,255,255);
    if (firstPathLevel == 0) {
      textSize(16);
      text("Level 1", x - 104.5, y - 167.5);
      textSize(12);
      text("Increase penetration level to 2. If \nmonster doesn't die immediately \nbullet won't go through, however \nAlso, decreases bullet speed", x - 104.5, y - 150);
    } else if (firstPathLevel == 1) {
      textSize(16);
      text("Level 2", x - 103.5, y - 165);
      textSize(12);
      text("Increase penetration level to 3, \ndecrease bullet speed, and \nincrease damage rate by 20", x - 103.5, y - 145);
    }
  }

  void displaySecondUpgradeText() {
    fill(255,255,255);
    if (firstPathLevel == 0) {
      textSize(16);
      text("Level 1", x - 78.5, y - 165);
      textSize(12);
      text("Double firerate and increase \nbullet speed", x - 78.5, y - 145);
    } else if (firstPathLevel == 1) {
      textSize(16);
      text("Level 2", x - 78.5, y - 165);
      textSize(12);
      text("Shoots bullets twice at a time and increases bullet speed", x - 78.5, y - 145);
    }
  }
}

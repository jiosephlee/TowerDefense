abstract class Towers {

  float x, y, fireRate, damage, shotTime;
  int firstPathLevel, secondPathLevel, range, price, size, penetrationLvl, speedChange, Color;
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
  void display() {
    fill(Color);
    ellipse(x, y, size, size);
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
    if (!onemaxed && distance(mouseX, mouseY, x-50, y-30) <= size) {
      upgradeFirst();
      upgrading = false;
      upgrade.notDisplay();
    } else if (!twomaxed && distance(mouseX, mouseY, x+50, y-30) <= size) {
      upgradeSecond();
      upgrading = false;
      upgrade.notDisplay();
    } else if (distance(mouseX, mouseY, x, y + 40) <= 15) {
      upgrading = false;
      upgrade.notDisplay();
      Towers.remove(this);
    } else if (distance(mouseX, mouseY, x, y) <= size) {
      upgrading = false;
      upgrade.notDisplay();
    }
  }
}

class BasicTower extends Towers {

  int bulletSpread;
  BasicTower(float xA, float yA) {
    super(xA, yA, 40, 100, 1, 5);
    price = 10;
    bulletSpread = 1;
    Color = color(103, 207, 45);
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

class FollowTower extends Towers {
  int bulletBeat;
  FollowTower(float xA, float yA) {
    super(xA, yA, 40, 100, 1, 5);
    price = 25;
    bulletBeat=1;
    Color = color(173, 107, 245);
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
    fill(255, 255, 255);
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
    fill(255, 255, 255);
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
class MortarTower extends Towers {
  float blastRadius;
  MortarTower(float xA, float yA) {
    super(xA, yA, 25, 800, 2.0, 10);
    blastRadius = 75;
    price = 40;
    Color = color(213, 324, 23);
  }
  void attack() {

    if ((millis() - shotTime)/1000.0 >= fireRate && Monsters.size() > 0) {     //if more than the time that firerate dictates has passed, then it shoots again
      Projectiles.add(new MortarShell(x, y, Monsters.get(0), damage, blastRadius));
      shotTime = millis();
    }
  }

  void upgradeFirst() {
    if (m.changeMoney(-(1 + firstPathLevel) * 15 )) {
      if (firstPathLevel == 0) {
        size+=5;
        damage+= 5;
        twomaxed = true;
      } else if (firstPathLevel == 1) {
        size+=5;
        blastRadius+=25;
        onemaxed = true;
      }
      price += (1 + firstPathLevel) * 15;
      firstPathLevel++;
    }
  }
  void upgradeSecond() {
    if (m.changeMoney(-(1 + secondPathLevel) * 15)) {
      if (secondPathLevel == 0) {
        fireRate = 1.5;
        onemaxed = true;
      } else if (secondPathLevel == 1) {
        fireRate = 1;
        twomaxed = true;
      }
      price += (1 + firstPathLevel) * 15;
      secondPathLevel++;
    }
  }
  void displayFirstUpgradeText() {
    fill(255, 255, 255);
    if (firstPathLevel == 0) {
      textSize(16);
      text("Level 1 ($15) ", x - 104.5, y - 167.5);
      textSize(12);
      text("Increase damage by 5 points", x - 104.5, y - 150);
    } else if (firstPathLevel == 1) {
      textSize(16);
      text("Level 2 ($30)", x - 103.5, y - 165);
      textSize(12);
      text("Increase blast radius", x - 103.5, y - 145);
    }
  }

  void displaySecondUpgradeText() {
    fill(255, 255, 255);
    if (firstPathLevel == 0) {
      textSize(16);
      text("Level 1 ($10)", x - 78.5, y - 165);
      textSize(12);
      text("Increase fire rate by 50%", x - 78.5, y - 145);
    } else if (firstPathLevel == 1) {
      textSize(16);
      text("Level 2 ($30)", x - 78.5, y - 165);
      textSize(12);
      text("Doubles initial fireRate", x - 78.5, y - 145);
    }
  }
}

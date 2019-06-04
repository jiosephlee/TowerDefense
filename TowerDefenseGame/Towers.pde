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
    speedChange = 0; //variable used to influence projectile speeds through tower upgrades
    onemaxed = false; //signifies when path is maxed out
    twomaxed = false;
    upgrade = new upgradeButton(this); //each tower has their own upgrade button set. The object is a "set" of buttons that belong to the tower
  }

  abstract void attack();
  abstract void upgradeFirst(); //upgrades a tower's first path
  abstract void upgradeSecond(); // upgrades a tower's second path
  abstract void displayFirstUpgradeText(); //displays first path text
  abstract void displaySecondUpgradeText(); //displays second path text

  void setxy(float xA, float yA) {
    x = xA; 
    y = yA;
  }
  void display() { 
    fill(Color);
    ellipse(x, y, size, size);
  }
  void checkInitiated() { //check if tower has been clicked to initate upgrade/selling
    if (distance(mouseX, mouseY, x, y) <= size) { //if it has
      for (Towers i : Towers) { //turn off all towers' click status
        i.upgrade.notDisplay();
      }
      upgrading = true; 
      upgrade.yesDisplay(); // then turn on mine
    }
  }
  void checkUpgradesClicked() { //check if one of the tower's buttons has been clicked
    if (upgrade.display) {
      if (!onemaxed && distance(mouseX, mouseY, x-50, y-30) <= size) { //if left most button has been clicked
        upgradeFirst();
        upgrading = false;
        upgrade.notDisplay();
      } else if (!twomaxed && distance(mouseX, mouseY, x+50, y-30) <= size) { //if right most button has been clicked
        upgradeSecond();
        upgrading = false;
        upgrade.notDisplay();
      } else if (distance(mouseX, mouseY, x, y + 40) <= 15) { // if sell button has been clicked
        upgrading = false;
        upgrade.notDisplay();
        m.changeMoney(this.price/2);
        Towers.remove(this);
      } else if (distance(mouseX, mouseY, x, y) <= size) { //if tower has been clicked, undo the upgrading graphics
        upgrading = false;
        upgrade.notDisplay();
      }
    }
  }
}
/*











*/
class BasiccTower extends Towers {

  int bulletSpread;
  BasiccTower(float xA, float yA) {
    super(xA, yA, 40, 100, 1, 5);
    price = 15;
    bulletSpread = 1;
    Color = color(103, 207, 45);
  }



  void attack() {
    if (resting && (millis() - shotTime)/1000 >= fireRate) {   //if more than the time that firerate dictates has passed, then it shoots again
      resting = false;
    }
    if (!resting) {
      for (Monster i : Monsters) {
        if (distance(i.x, i.y, x, y) <= range) { //if monster if is in range of the tower, then shoot a projectile at it and mark the time it shot for firerate checking
          for (int j = bulletSpread; j > 0; j--) {
            Projectiles.add(new StraightBullet(x, y, i, damage, size, penetrationLvl, speedChange, Color));
          }
          resting = true; //tell the tower it's resting 
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
      price += (1 + firstPathLevel) * 5;
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
      price += (1 + firstPathLevel) * 5;
    }
  }
  void displayFirstUpgradeText() {
    fill(255, 255, 255);
    if (firstPathLevel == 0) {
      textSize(16);
      text("Level 1 ($5)", x - 104.5, y - 165);
      textSize(12);
      text("Increase penetration level to 2. If \nmonster doesn't die immediately \nbullet won't go through, however", x - 104.5, y - 145);
    } else if (firstPathLevel == 1) {
      textSize(16);
      text("Level 2 ($10)", x - 100, y - 165);
      textSize(12);
      text("Increase damage rate by 10", x - 100, y - 145);
    } else if (firstPathLevel == 2) {
      textSize(16);
      text("Level 3 ($15)", x - 100, y - 165);
      textSize(12);
      text("Increase penetration level \nto 3 and damage rate by 5 \nbut decrease bullet speed", x - 100, y - 145);
    }
  }

  void displaySecondUpgradeText() {
    fill(255, 255, 255);
    if (secondPathLevel == 0) {
      textSize(16);
      text("Level 1 ($5)", x - 80, y - 165);
      textSize(12);
      text("Double firerate by 2", x - 80, y - 145);
    } else if (secondPathLevel == 1) {
      textSize(16);
      text("Level 2 ($10)", x - 80, y - 165);
      textSize(12);
      text("Increase bullet speed and \ndamage rate by 5", x - 80, y - 145);
    } else if (secondPathLevel == 2) {
      textSize(16);
      text("Level 3 ($15)", x - 80, y - 165);
      textSize(12);
      text("Shoots a spread of 3 bullets", x - 80, y - 145);
    }
  }
}
/*











*/
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
          Projectiles.add(new followBullet(x, y, i, damage, size, penetrationLvl, speedChange, Color));
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
      price += (1 + firstPathLevel) * 5;
    }
  }

  void upgradeSecond() {
    if (m.changeMoney(-(2 + secondPathLevel) * 5)) {
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
      price += (1 + firstPathLevel) * 5;
    }
  }
  void displayFirstUpgradeText() {
    fill(255, 255, 255);
    if (firstPathLevel == 0) {
      textSize(16);
      text("Level 1 ($10)", x - 104.5, y - 167.5);
      textSize(12);
      text("Increase penetration level to 2. If \nmonster doesn't die immediately \nbullet won't go through, however \nAlso, decreases bullet speed", x - 104.5, y - 150);
    } else if (firstPathLevel == 1) {
      textSize(16);
      text("Level 2 ($15)", x - 103.5, y - 165);
      textSize(12);
      text("Increase penetration level to 3, \ndecrease bullet speed, and \nincrease damage rate by 20", x - 103.5, y - 145);
    }
  }

  void displaySecondUpgradeText() {
    fill(255, 255, 255);
    if (firstPathLevel == 0) {
      textSize(16);
      text("Level 1 ($10)", x - 78.5, y - 165);
      textSize(12);
      text("Double firerate and increase \nbullet speed", x - 78.5, y - 145);
    } else if (firstPathLevel == 1) {
      textSize(16);
      text("Level 2 ($15)", x - 78.5, y - 165);
      textSize(12);
      text("Shoots bullets twice at a time and increases bullet speed", x - 78.5, y - 145);
    }
  }
}

class MortarTower extends Towers {
  float blastRadius;
  MortarTower(float xA, float yA) {
    super(xA, yA, 40, 800, 2.0, 5);
    blastRadius = 75;
    price = 40;
    Color = color(213, 324, 23);
  }
  void attack() {

    if ((millis() - shotTime)/1000.0 >= fireRate && Monsters.size() > 0) {     //if more than the time that firerate dictates has passed, then it shoots again
      Projectiles.add(new MortarShell(x, y, Monsters.get(0), damage, blastRadius, Color));
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

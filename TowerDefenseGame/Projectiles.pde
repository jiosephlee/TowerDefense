abstract class Projectiles {
  float vx, vy, x, y, damage, speed;
  int penetrationLevel, size;
  boolean canAttackArmored, doneShooting, dead;


  Projectiles(float xA, float yA, Monster i, float damageA, int sizeA, int penetrationLvl, int speedChange) {
    speed = 5 + speedChange;
    vx = ((i.x - xA)/ (float)Math.sqrt(Math.pow(i.x - xA, 2) + Math.pow(i.y - yA, 2))) * speed;
    vy = ((i.y - yA)/ (float)Math.sqrt(Math.pow(i.x - xA, 2) + Math.pow(i.y - yA, 2))) * speed;
    size = sizeA;
    canAttackArmored = false;
    x = xA;
    y = yA;
    penetrationLevel = penetrationLvl;
    dead = false;
    damage = damageA;
    //level = 1;
  }
  boolean dealDamage(Monster i) {
    if (Math.pow(i.x - x, 2) + Math.pow(i.y - y, 2) <= Math.pow(size, 2)) { //monster is in bullet's range
      if (i.changeHP(-1 * damage) <=0) {
        penetrationLevel--;
        if (penetrationLevel <= 0) { //if pentration level dips below 0, kill the bullet
          dead = true;
          toDestroyA.add(this);
        }
      } else { //if bullet wasn't able to the monster completely, kill the bullet
        toDestroyA.add(this);
        dead = true;
      }
      return true;
    }
    return false;
  }
  abstract void move();
}

class StraightBullet extends Projectiles {
  StraightBullet(float xA, float yA, Monster i, float damage, int sizeA, int penetrationLvl, int speedChange) {
    super(xA, yA, i, damage, sizeA, penetrationLvl, speedChange);
  }
  void move() {
    if (!dead) {
      x += vx;
      y += vy;
      for (Monster m : Monsters) {
        if (this.x < 0 || this.x > 1280 || this.y < 0 || this.y > 720) {
          dead = true;
          toDestroyA.add(this);
          break;
        }
        if (this.dealDamage(m)) {
          break;
        }
      }
    }
  }
}

class followBullet extends Projectiles {
  float turnedTime;
  Monster monster;
  boolean resting, gostraight;
  followBullet(float xA, float yA, Monster i, float damage, int sizeA, int penetrationLvl, int speedChange) {
    super(xA, yA, i, damage, sizeA, penetrationLvl, speedChange);
    monster = i;
    resting = true;
    turnedTime =  millis();
    gostraight=false;
    dead = false;
  }
  void move() {
    if (!dead) {
      x += vx;
      y += vy;
      for (Monster m : Monsters) {
        if (this.x < 0 || this.x > 1280 || this.y < 0 || this.y > 720) { //if its beyond the borders, kill it
          toDestroyA.add(this);
          dead = true;
          break;
        }
        if (this.dealDamage(m)) { //if it dealed damange, stop looping through monsters
          break;
        }
      }
      if (resting && (millis() - turnedTime)/70 >= 1) { //if it's resting and .07 seconds passed since it was redirected, say it's not resting
        resting = false;
      }
      if (!resting && !gostraight && !dead) { //if it's not resting, redirect the bullet towards the monster and then set the time it was turned
        if (monster.bad) {
          if (Monsters.size() > 0) { //if their are monsters on the map, get a new monster
            int a = this.nearestMonster(Monsters);
            if ( a > -1) { //a is non-negative when nearest monster thats not too far exists. in that case target onto that
              monster = Monsters.get(a);
              print(a);
            } else { //a is negative when the nearest monster is really far. in that case its too far so lets continue going straight instead
              gostraight=true;
            }
          } else { //if there's no monsters on the map, just go straight
            gostraight = true;
          }
        }
        vx = ((monster.x - x)/ (float)Math.sqrt(Math.pow(monster.x - x, 2) + Math.pow(monster.y - y, 2))) * speed;
        vy = ((monster.y - y)/ (float)Math.sqrt(Math.pow(monster.x - x, 2) + Math.pow(monster.y - y, 2))) * speed;
        turnedTime = millis();
      }
    }
  }

  boolean dealDamage(Monster i) {
    if (Math.pow(i.x - x, 2) + Math.pow(i.y - y, 2) <= Math.pow(size, 2)) { //if monster is in bullet's range
      if (i.changeHP(-1 * damage) <=0) { // if monster died
        monster.setBad();
        Monsters.remove(monster);// remove dead monster so you dont target it again
        if (Monsters.size() > 0) { //if their are monsters on the map, get a new monster
          int a = this.nearestMonster(Monsters);
          if ( a > -1) { //a is non-negative when nearest monster thats not too far exists. in that case target onto that
            monster = Monsters.get(a);
            print(a);
          } else { //a is negative when the nearest monster is really far. in that case its too far so lets continue going straight instead
            gostraight=true;
          }
        } else { //if there's no monsters on the map, just go straight
          gostraight = true;
        }
        penetrationLevel--;
        if (penetrationLevel <= 0) { //if pentration level dips below 0, kill the bullet
          toDestroyA.add(this);
          dead = true;
        }
      } else { //if bullet wasn't able to the monster completely, kill the bullet
        toDestroyA.add(this);
        dead = true;
      }
      return true;
    }
    return false;
  }

  int nearestMonster(LinkedList<Monster> Monsters) {
    float smallest = distance(this.x, this.y, Monsters.get(0).x, Monsters.get(0).y);
    int smallind = 0;
    int count = 0;
    for (Monster i : Monsters) { //go through every monster and find the nearest one
      if (distance(this.x, this.y, i.x, i.y) < smallest) {
        smallest = distance(this.x, this.y, i.x, i.y);
        smallind = count;
      }
      count++;
    }
    if (smallest > 200) { //if the nearest monster is further than 200 pixels, then just go straight instead. 
      return -1;
    }
    return smallind;
  }
}

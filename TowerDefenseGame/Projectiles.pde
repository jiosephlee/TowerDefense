abstract class Projectiles {
  float vx, vy, x, y, damage, speed;
  int penetrationLevel, size;
  boolean canAttackArmored, doneShooting;


  Projectiles(float xA, float yA, Monster i, float damageA) {
    speed = 5;
    vx = ((i.x - xA)/ (float)Math.sqrt(Math.pow(i.x - xA, 2) + Math.pow(i.y - yA, 2))) * speed;
    vy = ((i.y - yA)/ (float)Math.sqrt(Math.pow(i.x - xA, 2) + Math.pow(i.y - yA, 2))) * speed;
    size = 20;
    canAttackArmored = false;
    x = xA;
    y = yA;
    penetrationLevel = 2;

    damage = damageA;
    //level = 1;
  }
  boolean dealDamage(Monster i) {
    if (Math.pow(i.x - x, 2) + Math.pow(i.y - y, 2) <= Math.pow(size, 2)) { //monster is in bullet's range
      i.changeHP(-1 * damage);
      penetrationLevel--;
      if (penetrationLevel <= 0) { //if pentration level dips below 0, kill the bullet
        toDestroyA.add(this);
      }
      return true;
    }
    return false;
  }
  void move() {
    x += vx;
    y += vy;
    for (Monster m : Monsters) {
      if (this.x < 0 || this.x > 1280 || this.y < 0 || this.y > 720) {
        toDestroyA.add(this);
        break;
      }
      if (this.dealDamage(m)) {
        break;
      }
    }
  }
}

class StraightBullet extends Projectiles {
  StraightBullet(float xA, float yA, Monster i, float damage) {
    super(xA, yA, i, damage);
  }
  void move() {
    super.move();
  }
}

class followBullet extends Projectiles {
  float turnedTime;
  Monster monster;
  boolean resting;
  followBullet(float xA, float yA, Monster i, float damage) {
    super(xA, yA, i, damage);
    monster = i;
    resting = true;
    turnedTime =  millis();
  }
  void move() {
    super.move(); //move foward
    if (monster == null) { //if monster died, reset its target
      monster = Monsters.get(0);
    }
    if (resting && (millis() - turnedTime)/70 >= 1) { //if it's resting and .07 seconds passed since it was redirected, say it's not resting
      resting = false;
    }
    if (!resting) { //if it's not resting, redirect the bullet towards the monster and then set the time it was turned
      vx = ((monster.x - x)/ (float)Math.sqrt(Math.pow(monster.x - x, 2) + Math.pow(monster.y - y, 2))) * speed;
      vy = ((monster.y - y)/ (float)Math.sqrt(Math.pow(monster.x - x, 2) + Math.pow(monster.y - y, 2))) * speed;
      turnedTime = millis();
    }
  }

  boolean dealDamage(Monster i) {
    if (Math.pow(i.x - x, 2) + Math.pow(i.y - y, 2) <= Math.pow(size, 2)) { //monster is in bullet's range
      if (i.changeHP(-1 * damage) <=0) {
        monster = null;
        penetrationLevel--;
        if (penetrationLevel <= 0) { //if pentration level dips below 0, kill the bullet
          toDestroyA.add(this);
        }
      } else{ //if bullet wasn't able to the monster completely, kill the bullet
        toDestroyA.add(this);
      }
      return true;
    }
    return false;
  }
}

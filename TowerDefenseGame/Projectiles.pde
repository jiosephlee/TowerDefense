abstract class Projectiles {
  float vx,vy, x,y, damage,speed;
  int penetrationLevel, size;
  boolean canAttackArmored, doneShooting;

  
  Projectiles(float xA, float yA, Monster i, float damageA){
    speed = 4;
    vx = ((i.x - xA)/ (float)Math.sqrt(Math.pow(i.x - xA,2) + Math.pow(i.y - yA,2))) * speed;
    vy = ((i.y - yA)/ (float)Math.sqrt(Math.pow(i.x - xA,2) + Math.pow(i.y - yA,2))) * speed;
    size = 20;
    canAttackArmored = false;
    x = xA;
    y = yA;
    penetrationLevel = 2;

    damage = damageA;
    //level = 1;
  }
  boolean dealDamage(Monster i){
    if(Math.pow(i.x - x,2) + Math.pow(i.y - y,2) <= Math.pow(size,2)){ //monster is in bullet's range
      i.changeHP(-1 * damage);
      penetrationLevel--;
      if(penetrationLevel <= 0){ //if pentration level dips below 0, kill the bullet
        toDestroyA.add(this);
      }
      return true;
    } 
    return false;
  }
  abstract void move();
}

class StraightBullet extends Projectiles{
  StraightBullet(float xA, float yA, Monster i, float damage){
    super(xA, yA, i, damage);
  }
  void move(){
    x += vx;
    y += vy;
  }
}

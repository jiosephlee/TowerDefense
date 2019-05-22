abstract class Projectiles {
  float vx,vy, x,y;
  int level, size, speed, damage;
  boolean canAttackArmored;

  Projectiles(float xA, float yA, int damageA, Monster i){
    speed = 5;
    vx = (i.x - xA/ (float)Math.sqrt(Math.pow(i.x - xA,2) + Math.pow(i.y - yA,2))) * speed;
    vy = (i.y - yA/ (float)Math.sqrt(Math.pow(i.x - xA,2) + Math.pow(i.y - yA,2))) * speed;
    level = 1;
    size = 20;
    canAttackArmored = false;
    x = xA;
    y = yA;
    damage = damageA;
    level = 1;
  }
  boolean dealDamage(Monster i){
    if(Math.pow(i.x - x,2) + Math.pow(i.y - y,2) <= Math.pow(size,2)){
      i.changeHP(-1 * damage);
      return true;
    }
  }
  void move(){
    x += vx * speed;
    y += vy * speed;
  }
}

class abstract Towers{
  float x,y, size, angle, range, firerate, damage;
  int firstPathLevel, secondPathLevel;
  
  Towers(float xA, float yA, float sizeA, float angleA, float rangeA, float firerateA, float damageA){
    x = xA;
    y = yA;
    size = sizeA;
    angle = angleA;
    range = rangeA;
    firerate = firerateA;
    damage = damageA;
  }
  
  abstract void attack(){
  }
}

class Tower1 extends Towers{
  
  Tower1(xA,yA){
    super.Towers(
  
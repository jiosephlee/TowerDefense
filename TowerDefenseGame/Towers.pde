class abstract Towers{
  float x,y, size, range, firerate, damage;
  int firstPathLevel, secondPathLevel;
  
  Towers(float xA, float yA, float sizeA, float rangeA, float firerateA, float damageA){
    x = xA;
    y = yA;
    size = sizeA;
    range = rangeA;
    firerate = firerateA;
    damage = damageA;
  }
  
  abstract void attack(){
  }
}

class Tower1 extends Towers{
  
  Tower1(xA,yA){
    super(xA,yA,30,60,1,5,);
  }
  
  attack(LinkedList<Monster> Monsters){
    for(Monster i: Monsters){
      
  }
}

  
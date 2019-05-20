abstract class Towers {
  float x, y, size, range, firerate, damage;
  int firstPathLevel, secondPathLevel;

  Towers(float xA, float yA, float sizeA, float rangeA, float firerateA, float damageA) {
    x = xA;
    y = yA;
    size = sizeA;
    range = rangeA;
    firerate = firerateA;
    damage = damageA;
  }

  abstract void attack(LinkedList<Monster> Monsters);
}

class Tower1 extends Towers {

  Tower1(float xA, float yA) {
    super(xA, yA, 30, 60, 1, 5);
  }

  void attack(LinkedList<Monster> Monsters) {
    for (Monster i : Monsters) {
    }
  }
}

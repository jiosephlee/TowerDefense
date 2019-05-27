class Spawner {
  int level;
  double levelTime;
  double timeSinceLevel;
  float spawnRate;
  float maxMonsters;
  int spawned; 
  long pauseTime;
  Spawner() {
    level = 0;
  }
  void newLevel() {
    spawnRate = 1.25 + (1.0/3) * pow(level, 1.0/3);
    maxMonsters = 2* pow(level, 0.75) + 4;
    spawned = 0;
    level++;
    levelTime = System.currentTimeMillis();
  }
  void pause() {
    pauseTime = System.currentTimeMillis();
  }
  void go() {
    long time = System.currentTimeMillis();
    levelTime += (time - pauseTime);
  }
  void resetTime() {
    levelTime = System.currentTimeMillis();
    pauseTime  = 0;
  }
  void update() {
    timeSinceLevel = (System.currentTimeMillis() - levelTime)/1000.0;
    if (timeSinceLevel * spawnRate > spawned && spawned <= maxMonsters) {
      if (level > 3 && Math.random() < 0.25) {
        Monsters.add(new RedSlime(p));
        spawned += 3;
      } else {
        Monsters.add(new Slime(p));
        spawned++;
      }
    }
    //println("yuh " + spawned + " " + maxMonsters + " " +Monsters.size());
    if (spawned > maxMonsters && Monsters.size() == 0) {
      newLevel();
      gameMode = 3;
    }
  }
}

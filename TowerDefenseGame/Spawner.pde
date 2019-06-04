class Spawner {
  int level; //tracks level
  long levelTime; //tracks when the level started
  float timeSinceLevel; //tracks how long its been since the level started
  float spawnRate; //how fast to spawn monsters
  float maxMonsters; //maximum number of monsters to spawn per level
  int spawned; //number of spawned monsters
  long pauseTime; //when a pause has started
  Spawner() {
    level = 0; //start at level 0
  }
  void newLevel() {
    //starts a new level, clears projectiles
    Projectiles.clear();
    //uses equations to calculate its spawnRate and maximum number of monsters
    spawnRate = 1.25 + (1.0/3) * pow(level, 1.0/3);
    maxMonsters = 2* pow(level, 1.25) + 4;
    spawned = 0;
    level++;
    //recorsd when the level has started
    levelTime = System.currentTimeMillis();
    if(level > 25){
      Monsters.add(new BossK(p));
    }
  }
  void pause() {
    //records when the gamme was paused
    pauseTime = System.currentTimeMillis();
  }
  void go() {
    //resumes the game after a pause and compensates for that in time elapsed
    long time = System.currentTimeMillis();
    levelTime += (time - pauseTime);
    for(Projectiles p: Projectiles){
      p.clearTime();
    }
  }
  void resetTime() {
    //reset the time counter after each level
    levelTime = System.currentTimeMillis();
    pauseTime  = 0;
  }
  void update() {
    //time elapsed * spawn rate is equal to number of monsters that should be spawned
    timeSinceLevel = (System.currentTimeMillis() - levelTime)/1000.0;
    if (timeSinceLevel * spawnRate > spawned && spawned <= maxMonsters) {
      //25% chance of spawning a red slime after level 3
      if(level > 25 && Math.random() < 0.01){
        Monsters.add(new BossK(p));
        spawned += 10;
      }
      if (level > 4 && Math.random() < 0.125) {
        Monsters.add(new Tank(p));
        spawned += 6;
      } else if (level > 3 && Math.random() < 0.25) {
        Monsters.add(new RedSlime(p));
        spawned += 3;
      } else if (level > 2 && Math.random() < 0.25) {
        Monsters.add(new Mushroom(p));
        spawned ++;
      } else {
        //otherwise just spawn a normal slime
        Monsters.add(new Slime(p));
        spawned++;
      }
    }

    if (spawned > maxMonsters && Monsters.size() == 0) {
      //pauses the game if all monsters have been killed and starts new level
      newLevel();
      gameMode = 3;
    }
  }
}

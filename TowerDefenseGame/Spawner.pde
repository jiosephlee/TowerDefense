class Spawner{
  int level;
  double levelTime;
  double timeSinceLevel;
  float spawnRate;
  float maxMonsters;
  int spawned; 
  
  Spawner(){
    level = 0;
    newLevel();
  }
  void newLevel(){
    spawnRate = 0.25 + 0.25 * pow(level,1.0/3);
    maxMonsters = pow(level,0.75) + 5;
    spawned = 0;
    level++;
    levelTime = System.currentTimeMillis();
  }
  void update(){
    timeSinceLevel = (System.currentTimeMillis() - levelTime)/1000.0;
    if(timeSinceLevel * spawnRate > spawned && spawned <= maxMonsters){
      Monsters.add(new Slime(p));
      spawned++;
    }
    //println("yuh " + spawned + " " + maxMonsters + " " +Monsters.size());
    if(spawned > maxMonsters && Monsters.size() == 0){
      newLevel();
    }
  }
}

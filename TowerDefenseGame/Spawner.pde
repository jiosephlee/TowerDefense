class Spawner{
  int level;
  double levelTime;
  double timeSinceLevel;
  float[] spawnRate = {1,1.25,1.5,2,2.5,3.5,4,5,6,7};
  
  Spawner(){
    level = 1;
  }
  void newLevel(){
    level++;
    levelTime = System.currentTimeMillis();
  }
  void update(){
    timeSinceLevel = System.currentTimeMillis() - levelTime;
    
  }
}

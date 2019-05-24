class Map {
  //PImage zones;
  float hp;
  int money;
  Map() {
    background = loadImage("images/Map1Background.PNG");
    mapZones = loadImage("images/Map1Zones.png");
    hp = 100;
    money = 20;
  }
  void display() {
    imageMode(CORNER);
    image(background, 0, 0);
  }
  void changeHP(float x){
    hp -= x;
    if(hp < 0){
      textSize(72);
      text("GAME OVER", height/2, width/2);
    }
  }
  void changeMoney(int a){
    money += a;
  }
}

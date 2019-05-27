class Map {
  //PImage zones;
  float hp;
  Map() {
    background = loadImage("images/Map1Background.PNG");
    mapZones = loadImage("images/Map1Zones.png");
    hp = 100;
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
}

class Button{
  float x,y;
  color a;
  Towers load;
  Button(float xA,float yA, Towers loaded){
    a = color(103, 192, 203);
    x = xA;
    y = yA;
    load = loaded;
  }
  void newTower(Towers newLoad){
    load = newLoad;
  }
  void display(){
    fill(a);
    rect(x, y, 40, 40);
  }
}

class Map {
  //PImage zones;
  float hp; //amount of hp until the game is over
  int money; //user's money
  Map() {
    background = loadImage("images/Map1Background.PNG"); 
    mapZones = loadImage("images/Map1Zones.png"); 
    //map zones is a special image of the background that is white where towers can be placed
    hp = 100;
    money = 50;
  }
  void display() {
    //display background
    imageMode(CORNER);
    image(background, 0, 0);
  }
  void changeHP(float x){
    //if hp negative, display game over
    hp -= x;
    if(hp < 0){
      textSize(72);
      text("GAME OVER", height/2, width/2);
    }
  }
  void changeMoney(int a){
    //modify the user's money
    money += a;
  }
}

class Button{
  float x,y;
  color Color;
  Towers load;
  Button(float xA,float yA, Towers loaded, color a){
    Color = a;
    x = xA;
    y = yA;
    load = loaded;
  }
  void newTower(Towers newLoad){
    load = newLoad;
  }
  void display(){
    fill(Color);
    rect(x, y, 40, 40);
    fill(0);
    textSize(12);
    text((load.getClass().getName() + "").substring(17,23), x - 50, y + 20);
  }
}

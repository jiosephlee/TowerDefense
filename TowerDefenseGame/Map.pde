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
    imageMode(CENTER);
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

abstract class Button{
  float x,y;
  color Color;
  Towers load;
  Button(float xA,float yA, Towers loaded, color a){
    Color = a;
    x = xA;
    y = yA;
    load = loaded;
  }
  abstract void newTower();
  void display(){
    fill(Color);
    rect(x, y, 40, 40);
    fill(0);
    textSize(12);
    text((load.getClass().getName() + "").substring(17,23), x - 50, y + 20);
  }
}

class Button1 extends Button{
  Button1(){
    super(1020, 200, new Tower1(-1, -1), color(103, 207, 45));
  }
  void newTower(){
    load = new Tower1(-1,-1);
  }
}

class Button2 extends Button{
  Button2(){
    super(1200, 200, new Tower2(-1, -1), color(173, 107, 245));
  }
  void newTower(){
    load = new Tower2(-1,-1);
  }
}
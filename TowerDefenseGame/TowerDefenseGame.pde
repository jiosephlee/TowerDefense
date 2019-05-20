void setup(){
  size(1280, 720);
  background(255);
}
void draw(){
  background(255);
  fill(255,0,0);
  ellipse(mouseX + 100,mouseY + 100,25,25);
  fill(0);
  textSize(36);
  text("x: " + mouseX, 50, 50); 
  text("y: " + mouseY, 50, 100); 
  textSize(20);
  text("© Boseph Bee and Biong Bhou Buang 2019", 50, 650); 
}

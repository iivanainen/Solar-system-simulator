Planet sun;

void setup() {
  size(1200, 1200);
  
  //creates the centre sun and moons
  sun = new Planet(50, 0, true);
  sun.spawnMoons(5, 1);
}

void draw() {
    background(0);
    translate(width / 2, height / 2);
    
    //shows and moves the planets
    sun.show();
    sun.orbit();
  
}

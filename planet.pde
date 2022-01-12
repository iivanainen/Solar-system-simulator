class Planet {
  
  //color for the centre sun
  float sunR = int(random(150, 255));
  float sunG = int(random(sunR - 150, sunR - 50));
  float sunB = int(random(0, sunR - 100));
  color suncolor = color(sunR, sunG, sunB);

  float radius;
  float angle;
  float distance;
  float orbitSpeed;
  boolean center;
  
  Planet[] planets;
  
  Planet(float r, float d, boolean c) {
    radius = r;
    distance = d;
    center = c;
    angle = random(TWO_PI);
    
    //makes orbital speed dependent on radius - smaller ones spin faster
    if (r > 10) {
      if (random(1) < 0.5) {
        orbitSpeed = random(PI/1080, PI/270);
      }
      else {
        orbitSpeed = random(-PI/1080, -PI/270);
      }
    }
    else {
      if (random(1) < 0.5) {
        orbitSpeed = random(PI/180, PI/50);
      }
      else {
        orbitSpeed = random(-PI/180, -PI/50);
      }
    }
  }
  
  void orbit() {
    
    //rotates if not the centre sun
    if (center == false) {
      angle = angle - orbitSpeed;
    }
    
    //also rotates child planets if there are any
    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].orbit();
      }
    }
  }
  
  void spawnMoons (int total, int level) {
    planets = new Planet[total];
    
    //creates planets and moons with decreasing size each level
    for (int i = 0; i < planets.length; i++) {
      float r = random(radius * 0.2, radius * 0.45)/(level * 0.25 +1);
      float d = radius * 2 + random(95, 770)/(factorial(level * 2));
      planets[i] = new Planet(r, d, false);

     //creates child planets and moons up to level and then stops
     if (level < 3) {
       float num = random(0.35) * (radius - 4) / (level * 2);
       if (num < 0) {
         num = 0;
       }
       
       planets[i].spawnMoons(int(num), level+1);
     }
   }
  }
  
  void show() {
    pushMatrix();
    rotate(angle);    
    translate(distance, 0);

    //makes sun colourful
    if (center == true) {
      noStroke();
      //ellipse(0, 0, radius * 2, radius * 2);
      drawGradient(0,0);
    }
    else {
      stroke(255);
      fill(100, 100, 100, 100);
      ellipse(0, 0, radius * 2, radius * 2);
    }
    
    //checks if there are planets and shows them
    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].show();
      }
    }
    popMatrix();
  }
  
  //function for drawing the colour gradient
  void drawGradient(float x, float y) {
    int begC = int(sunR);
    int minusB = 0;
    for (int g = int(radius) * 2; g > 0; g--) {
      fill(begC, begC - 30, sunB - minusB);
      ellipse(x, y, g, g);
      begC = (begC + 1);
      minusB = minusB + 1;
    }
  }
}

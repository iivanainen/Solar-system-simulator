class Planet {
    
  float sunR = int(random(150, 255));
  float sunG = int(random(sunR - 150, sunR - 50));
  float sunB = int(random(0, sunR - 100));
  color suncolor = color(sunR, sunG, sunB);

  float radius;
  float angle;
  float distance;
  float orbitSpeed;
  //float spin;
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
    //spin = spin + orbitSpeed;
    
    if (center == false) {
      angle = angle - orbitSpeed;
    }
    
    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].orbit();
      }
    }
  }
  
  void spawnMoons (int total, int level) {
    planets = new Planet[total];
    
    for (int i = 0; i < planets.length; i++) {
      float r = random(radius * 0.2, radius * 0.45)/(level * 0.25 +1);
      float d = radius * 2 + random(95, 770)/(factorial(level * 2));
      //float s = random(PI/180);
      planets[i] = new Planet(r, d, false);

     
     if (level < 3) {
       float num = random(0.5) * radius / (level * 2);
       
       planets[i].spawnMoons(int(num), level+1);
     }
   }
  }
  
  void show() {
    pushMatrix();
    rotate(angle);    
    translate(distance, 0);

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

    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].show();
      }
    }
    popMatrix();
  }
  
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

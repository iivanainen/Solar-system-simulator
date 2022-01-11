class Planet {
  
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
      float r = (radius * 0.33)/(level * 0.25 +1);
      float d = radius + random(95, 570)/factorial(level+1);
      //float s = random(PI/180);
      planets[i] = new Planet(r, d, false);
       
      if (d < radius * 2) {
      println("too close! distance: ", d, "radius: ", r);
      d = random(75, 370)/factorial(level+1);
      }
     
     if (level < 3) {
       float num = random(6) / (level * 2);
       
       planets[i].spawnMoons(int(num), level+1);
     }
   }
  }
  
  void show() {
    
    pushMatrix();
    rotate(angle);    
    translate(distance, 0);
    stroke(255);
    fill(100, 100, 100, 100);
    ellipse(0, 0, radius * 2, radius * 2);
    
    //line(-radius, 0, radius, 0);
    
    //printArray(planets);

    if (planets != null) {
      for (int i = 0; i < planets.length; i++) {
        planets[i].show();
      }
    }
    popMatrix();

   //rotate(spin);
  }
  
}

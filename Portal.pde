class Portal {
  Circle c;
 

  
  Portal () {
    float x, y, radius;
    
    x = random(100,700);
    y = random(100, 500);
    radius = 50;
    c = new Circle(x, y, radius);

  }
  
  
  Portal (Circle _c) {
    c = _c;
  }
  
  void setRectangle (Circle _r) {
    c = _r;
  }
  
  
  
  void setCircle (Circle _c) {
    c = _c;
  }
  
  Circle getCircle () {
    return c;
  }
  
  void display () {
    c.display();
  }
  
  /**
  Formule F = -0.5 * rho * ||v||^2 * area * friction * speed.normalise
  
  PVector draggingForce(PVector speed, float area) {
    float speedMag = speed.mag();
    float coeffRhoMag = density * coefficientFriction * speedMag * speedMag * 0.5;
    
    PVector result = speed.get();
    result.mult(-1);
    result.normalize();
    result.mult(area);
    result.mult(coeffRhoMag);
   
    return result;
  }*/
}

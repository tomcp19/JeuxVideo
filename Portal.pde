/**
  Classe simulant un fluide. Elle est représentée par un rectangle.
  
  Lab1: ●  L’objet fluide aura la largeur de la fenêtre et une hauteur aléatoire de 0.1 * height et 0.4 * height.
        ●  L’objet devra toujours toucher au bas de la fenêtre.
        ●  La densité du fluide sera une valeur aléatoire entre 1.5 et 3. Affichez la valeur de la densité bien identifiée dans le milieu du fluide.
        ●  Affichez votre nom en dessous de la valeur du fluide.

*/
class Portal {
  Rectangle r;
  float density;
  float coefficientFriction;
  
  Portal () {
    float quarterHeight = height / 4;
    r = new Rectangle(0, height - quarterHeight, width, quarterHeight);
    density = 0.8;
    coefficientFriction = 0.1;
  }
  
  Portal (Rectangle _r, float _density, float _coefficientFriction) {
    r = _r;
    density = _density;
    coefficientFriction = _coefficientFriction;
  }
  
  void setRectangle (Rectangle _r) {
    r = _r;
  }
  
  Rectangle getRectangle () {
    return r;
  }
  
  void display () {
    r.display();
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

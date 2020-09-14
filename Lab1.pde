/* Lab1: ajoutez une cinquantaine d’objets de masse aléatoire, suivant une distribution normale, auxquels on applique une force de gravité. Les objets devront rebondir au contact du sol avec un coefficient de restitution   de 90%.*/

int nbMovers = 50;
boolean hideFluid = false;

Mover[] movers;
Mover balloon;
Fluid fluid;
Rectangle rect;
PFont densityValue, me;
float randHeight, randDensity;

//----------------------------------------------------------------
void setup () {
  size (800, 600);
  movers = new Mover[nbMovers];

  balloon = new Mover();

  balloon.location.x = (width / 2);
  balloon.location.y = height-50;
  balloon.mass = 5;
  balloon.r = 255;
  balloon.b = 0;
  balloon.g = 0;
  balloon.a = 127;
  
  densityValue = createFont("Arial",16,true); 
  me = createFont("Arial",16,true); 
  
  randHeight = randomNb(0.10, 0.401)*height  ;//entre 0,1 et 0,4 * hauteur
  Rectangle rec = new Rectangle(0, height - randHeight, width, height*randHeight);
  
  randDensity = randomNb(1.50, 3.01);//entre 1.5 et 3
  fluid = new Fluid(rec, randDensity, 0.1 ); //(Rectangle _r, float _density, float _coefficientFriction)

  
  for (int i = 0; i < movers.length; i++) {

    movers[i] = new Mover();
    movers[i].r = 127;
    movers[i].b = 127;
    movers[i].g = 127;
    movers[i].a = 127;
    movers[i].mass = randomGaussian() * 3;
    movers[i].location.x = 30 + i * (width / nbMovers);
    if(movers[i].location.x > width)
    {
      movers[i].location.x = width/2;
    }
    movers[i].location.y = movers[i].size.y;
  }
}
 
float xOff = 0.0;
float n;
//------------------------------------------------------------------
void update() {

      PVector helium = new PVector (0, -0.1);
      balloon.applyForce(helium); 
      balloon.update();
      balloon.checkEdges();
      
  for (int i = 0; i < movers.length; i++) {
  
    //la restitution est dans la classe Mover dans checkEdge()
    float m = movers[i].mass;
    
    PVector gravity = new PVector (0, 0.1 * m);
    PVector restitution = new PVector (0, 0.1 * m);
    PVector friction = movers[i].velocity.get();
    
    friction.normalize();
    friction.mult(-1);
    friction.mult(0.02);
    
    if (mousePressed) {
      if(mouseX < movers[i].location.x)
      {
        PVector wind = new PVector (.1, 0);
        movers[i].applyForce(wind);
        balloon.applyForce(wind);
      }
     if(mouseX > movers[i].location.x)
      {
        PVector wind = new PVector (-.1, 0);
        movers[i].applyForce(wind);
        balloon.applyForce(wind);
      }
    }
    
    if (fluid.getRectangle().intersect(movers[i].getRectangle())) {   
      PVector fForce = fluid.draggingForce(movers[i].velocity, movers[i].mass);
      movers[i].applyForce(fForce);
    }
    
    movers[i].applyForce(gravity);
    movers[i].applyForce(friction);
    movers[i].update();
    movers[i].checkEdges();
  }  
}
//-------------------------------------------------------------------------------------------
void keyPressed() { //Lorsque pressé, active/déactive le fluide ou repart le sketch
  
  if (key == ' ') 
  { 
      hideFluid = !hideFluid;
      
      if(hideFluid)
      {
         Rectangle rec = new Rectangle(0, height, width, 0);//flist.remove(0);
         fluid.setRectangle(rec);
      }
      
      if(!hideFluid)
      {    
          randHeight = randomNb(0.10, 0.401)*height  ;//entre 0,1 et 0,4 * hauteur
          Rectangle rec = new Rectangle(0, height - randHeight, width, height*randHeight);
    
          randDensity = randomNb(1.50, 3.01);//entre 1.5 et 3
          fluid = new Fluid(rec, randDensity, 0.1 ); //(Rectangle _r, float _density, float _coefficientFriction)
      }
  }

  if (key == 'r') 
  {  
     setup();
  }
}


float randomNb(float min, float max)
{
  float nb = random(min, max);
  return nb;
}

void render () {
  background (255);
  
  fill(#dbcf5c); //Code CIL pour huile d'olive https://encycolorpedia.com/dbcf5c
  fluid.display();

  balloon.display();
  
  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
}

void draw () {
  update();
  render(); 
      if (hideFluid == false) {   
        textFont(densityValue,16); 
        fill(0);                         
        text("Densité : " + nf(randDensity,0,2) + " g/L",width/3, height-randHeight/2 ); 
        textFont(me,16); 
        text("Tommy Landry",width/3,height-randHeight/4);  
    }
}

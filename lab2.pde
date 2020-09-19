int currentTime;
int previousTime;
int deltaTime;

Circle cPortalA;
Circle cPortalB;
boolean hide = false;

ArrayList<Mover> flock;
int flockSize = 10;
Portal portalA, portalB;

boolean debug = false;

void setup () {
  //fullScreen(P2D);
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  flock = new ArrayList<Mover>();
   
  portalA = new Portal();
  portalB = new Portal();
  
  portalA.getCircle().fillColor = color (200, 50, 0); //b.fillColor = color (0, 200, 0);
  portalB.getCircle().fillColor = color (0, 50, 255); //b.fillColor = color (0, 200, 0);
    
  cPortalA = portalA.getCircle();
  cPortalB = portalA.getCircle();
  
  while (portalB.getCircle().isCollidingCircle(portalA.getCircle())) {
  portalA = new Portal();
  portalB = new Portal();
  
  portalA.getCircle().fillColor = color (0, 200, 0); //b.fillColor = color (0, 200, 0);
  portalB.getCircle().fillColor = color (0, 200, 0); //b.fillColor = color (0, 200, 0);
    
  cPortalA = portalA.getCircle();
  cPortalB = portalA.getCircle();
  }

  //flock.get(0).debug = true;
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();  
}

/***
  The calculations should go here
*/
void update(int delta) {
  
  
  for (Mover m : flock) {
    m.flock(flock);
    m.update(delta);
    //m.getCircle().update();
    
    
     if(!hide){
  if (m.getCircle().isCollidingCircle(portalA.getCircle())) {

      float offsetx, offsety;
      
      offsetx = m.location.x - portalA.getCircle().location.x;
      offsety = m.location.y - portalA.getCircle().location.y;
      
      m.location.x = portalB.getCircle().location.x - offsetx;
      m.location.y = portalB.getCircle().location.y - offsety;
  } 
  
    else if (m.getCircle().isCollidingCircle(portalB.getCircle())) {
      
      float offsetx, offsety;
      
      offsetx = m.location.x - portalB.getCircle().location.x;
      offsety = m.location.y - portalB.getCircle().location.y;
      
      m.location.x = portalA.getCircle().location.x - offsetx;
      m.location.y = portalA.getCircle().location.y - offsety;

  }
     }

}
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  if(!hide){
  portalA.display();
    portalB.display();
  }
  for (Mover m : flock) {
    m.display();
    m.getCircle().display();
  }
}

void keyPressed() {
  switch (key) {
    /*case 'd':
      flock.get(0).debug = !flock.get(0).debug;
      break;*/
      
    case 'r':
       setup();
       break;
       
   case ' ':
   if(hide)
   {
       /*Circle c0 = new Circle(portalA.getCircle().location.x, portalA.getCircle().location.y,0);
       Circle c1 = new Circle(portalB.getCircle().location.x, portalB.getCircle().location.y,0);
       portalA.setCircle(c0);
       portalB.setCircle(c1);*/
       hide = false;
   }
   else if(!hide)
   {
       /*portalA.setCircle(cPortalA);
       portalB.setCircle(cPortalB);*/
       hide = true;
   }
    break;
       
  }
}

void mousePressed()
{
    boolean overlap = true;
    PVector loc = new PVector(mouseX, mouseY);
    PVector vel = new PVector(random(0, width), random(0, height));
    Mover m;
    Circle circ;
    //while(overlap)
    //{
      circ = new Circle(loc.x, loc.y, 5);
      m = new Mover(loc, vel, circ);
      m.fillColor = color(random(255), random(255), random(255));
      /*if (!((m.getCircle().isCollidingCircle(portalB.getCircle()))||(m.getCircle().isCollidingCircle(portalA.getCircle()))))
      {
      overlap = false;
      }*/
    //}
    flock.add(m);
 
}

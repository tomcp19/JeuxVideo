int currentTime;
int previousTime;
int deltaTime;

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
  
  Rectangle rectA = new Rectangle(100, 100, 100, 10);
  Rectangle rectB = new Rectangle(500, 300, 10, 100);
   
  portalA = new Portal(rectA, 0 ,0);
  portalB = new Portal(rectB, 0, 0);
  
  portalA.getCircle().fillColor = color (200, 50, 0); 
  portalB.getCircle().fillColor = color (0, 50, 255); 
    
  
  for (int i = 0; i < flockSize; i++) {
    Mover m = new Mover(new PVector(random(0, width), random(0, height)), new PVector(random (-2, 2), random(-2, 2)));
    m.fillColor = color(random(255), random(255), random(255));
    flock.add(m);
  }

  flock.get(0).debug = true;
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
    
      if (portalA.getRectangle().left() < m.location.x && portalA.getRectangle().right() > m.location.x) {  
        
            if (portalA.getRectangle().bottom() > m.location.y && portalA.getRectangle().top() < m.location.y) {  
                     m.location.x = portalB.getRectangle().left();
                     m.location.y = (portalB.getRectangle().top() + portalB.getRectangle().bottom())/2; 
                }           
    }
    
          if (portalA.getRectangle().top() < m.location.y && portalA.getRectangle().bottom() > m.location.y) {  
        
            if(portalA.getRectangle().left() < m.location.x && portalA.getRectangle().right() > m.location.x) {  
                     m.location.x = portalB.getRectangle().left();
                     m.location.y = (portalB.getRectangle().top() + portalB.getRectangle().bottom())/2; 
                }                
    }
    
      if (portalB.getRectangle().left() < m.location.x && portalB.getRectangle().right() > m.location.x) {  
        
            if (portalB.getRectangle().bottom() > m.location.y && portalB.getRectangle().top() < m.location.y) {  
                     m.location.x = (portalA.getRectangle().left() + portalA.getRectangle().right())/2;
                     m.location.y = portalA.getRectangle().bottom(); 
                }           
    }
    
          if (portalB.getRectangle().top() < m.location.y && portalB.getRectangle().bottom() > m.location.y) {  
        
            if(portalB.getRectangle().left() < m.location.x && portalB.getRectangle().right() > m.location.x) {  
                     m.location.x = (portalA.getRectangle().left() + portalA.getRectangle().right())/2;
                     m.location.y = portalA.getRectangle().bottom();
                }                
    }
  }
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  portalA.display();
  portalB.display();
  for (Mover m : flock) {
    m.display();
  }
}

void keyPressed() {
  switch (key) {
    case 'd':
      flock.get(0).debug = !flock.get(0).debug;
      break;
  }
}

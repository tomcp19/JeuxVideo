NodeMap worldMap;

int deltaTime = 0;
int previousTime = 0;
int mapRows = 100;
int mapCols = 100;

int rdmStart;
int rdmEnd;

color baseColor = color (0, 127, 0);

void setup () {
  //size (420, 420);
  fullScreen();
  
  initMap();
}

void draw () {
  deltaTime = millis () - previousTime;
  previousTime = millis();
  
  update(deltaTime);
  display();
}

void update (float delta) {
  worldMap.update(delta);
}

void display () {
  
  if (worldMap.path != null) {
    for (Cell c : worldMap.path) {
      c.setFillColor(color (127, 0, 0));
    }
  }
  
  worldMap.display();
}

void initMap () {
  worldMap = new NodeMap (mapRows, mapCols); 
  
  worldMap.setBaseColor(baseColor);
  
  //worldMap.setStartCell(generateRdmCell(mapCols), generateRdmCell(mapRows));
  //worldMap.setEndCell(generateRdmCell(mapCols), generateRdmCell(mapRows));
  
  // Mise à jour de tous les H des cellules

  
  worldMap.makeWall (mapCols / 2, 0, 15, true);
  worldMap.makeWall (mapCols / 2 - 9, 10, 10, false);
  
  worldMap.setStartCell(mapCols, mapRows);
  worldMap.setEndCell(mapCols, mapRows);
   worldMap.updateHs();
  
  
    
  worldMap.generateNeighbourhood(); //<>//
      
  worldMap.findAStarPath();
}

//int generateRdmCell(float max)
//{
  //float coord = random(max -1);
  //if(coord < 0) coord =0;
 // return (int)coord;
//}

void keyPressed()
{
  if(key == 'r')
  {setup ();}
}

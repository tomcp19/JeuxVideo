/********************
  Énumération des directions
  possibles
  
********************/
enum Direction {
  EAST, SOUTH, WEST, NORTH
}

/********************
  Représente une carte de cellule permettant
  de trouver le chemin le plus court entre deux cellules
  
********************/
class NodeMap extends Matrix {
  Node start;
  Node end;
  
  ArrayList <Node> path;
  
  boolean debug = false;
  
  NodeMap (int nbRows, int nbColumns) {
    super (nbRows, nbColumns);
  }
  
  NodeMap (int nbRows, int nbColumns, int bpp, int width, int height) {
    super (nbRows, nbColumns, bpp, width, height);
  }
  
  void init() {
    
    cells = new ArrayList<ArrayList<Cell>>();
    
    for (int j = 0; j < rows; j++){
      // Instanciation des rangees
      cells.add (new ArrayList<Cell>());
      
      for (int i = 0; i < cols; i++) {
        Cell temp = new Node(i * cellWidth, j * cellHeight, cellWidth, cellHeight);
        
        // Position matricielle
        temp.i = i;
        temp.j = j;
        
        cells.get(j).add (temp);
      }
    }
    
    println ("rows : " + rows + " -- cols : " + cols);
  }
  
  /*
    Configure la cellule de départ
  */
  void setStartCell (int mapCols, int mapRows) {
    
    if (start != null) {
      start.isStart = false;
      start.setFillColor(baseColor);
    } 
    
    float coordx = random(mapCols -1);
    if(coordx < 0) coordx =0;
    float coordy = random(mapCols -1);
    if(coordy < 0) coordy =0;
    
    start = (Node)cells.get((int)coordx).get((int)coordy);
    while(!start.isWalkable)
    {
     coordx = random(mapCols -1);
    if(coordx < 0) coordx =0;
    coordy = random(mapRows -1);
    if(coordy < 0) coordy =0; 
    }

    
    //start = (Node)cells.get((int)coordx).get((int)coordy);
    start.isStart = true;
    

    
    start.setFillColor(color (127, 0, 127));
  }
  
  /*
    Configure la cellule de fin
  */
  void setEndCell (int mapCols, int mapRows) {
    
    if (end != null) {
      end.isEnd = false;
      end.setFillColor(baseColor);
    }
    
    float coordx = random(mapCols -1);
    if(coordx < 0) coordx =0;
    float coordy = random(mapRows -1);
    if(coordy < 0) coordy =0;
    
    end = (Node)cells.get((int)coordx).get((int)coordy);
    while(!end.isWalkable)
    {
     coordx = random(mapCols -1);
    if(coordx < 0) coordx =0;
    coordy = random(mapRows -1);
    if(coordy < 0) coordy =0; 
    }
    
   //end = (Node)cells.get(j).get(i);
    end.isEnd = true;
    
    end.setFillColor(color (127, 127, 0));
  }
  
  /** Met a jour les H des cellules
  doit etre appele apres le changement du noeud
  de debut ou fin
  */
  void updateHs() {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        Node current = (Node)cells.get(j).get(i); 
        current.setH( calculateH(current));
      }
    }
  }
  
  // Permet de generer aleatoirement le cout de deplacement
  // entre chaque cellule
  void randomizeMovementCost() {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        
        int cost = parseInt(random (0, cols)) + 1;
        
        Node current = (Node)cells.get(j).get(i);
        current.setMovementCost(cost);
       
      }
    }
  }
  
  // Permet de generer les voisins de la cellule a la position indiquee
  void generateNeighbours(int i, int j) {
    Node c = (Node)getCell (i, j);
    if (debug) println ("Current cell : " + i + ", " + j);
    
    
    for (Direction d : Direction.values()) {
      Node neighbour = null;
      
      switch (d) {
        case EAST :
          if (i < cols - 1) {
            if (debug) println ("\tGetting " + d + " neighbour for " + i + ", " + j);
            neighbour = (Node)getCell(i + 1, j);
          }
          break;
        case SOUTH :
          if (j < rows - 1) {
            if (debug) println ("\tGetting " + d + " neighbour for " + i + ", " + j);
            neighbour = (Node)getCell(i, j + 1);
          }
          break;
        case WEST :
          if (i > 0) {
            if (debug) println ("\tGetting " + d + " neighbour for " + i + ", " + j);
            neighbour = (Node)getCell(i - 1, j);
          }
          break;
        case NORTH :
          if (j > 0) {
            if (debug) println ("\tGetting " + d + " neighbour for " + i + ", " + j);
            neighbour = (Node)getCell(i, j - 1);
          }
          break;
      }
      
      if (neighbour != null) {
        if (neighbour.isWalkable) {
          c.addNeighbour(neighbour);
        }
      }
    }
  }
  
  /**
    Génère les voisins de chaque Noeud
    Pas la méthode la plus efficace car ça
    prend beaucoup de mémoire.
    Idéalement, on devrait le faire au besoin
  */
  void generateNeighbourhood() {
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {

        generateNeighbours(i, j);
      }
    }
  }
  //*********************************************************************************
  /*
    Permet de trouver le chemin le plus court entre
    deux cellules
  */
  void findAStarPath () {
    
    ArrayList<Node> openList = new ArrayList<Node>();
    ArrayList<Node> closedList = new ArrayList<Node>();
    Node CurrentNode = start;
   
    
    //start.setG(0);
    
    if (start == null || end == null) {
      println ("No start and no end defined!");
      return;
    }
    
    //-------------debug-------------
    /*for (int j = 0; j < rows; j++)
  { 
      for (int i = 0; i < cols; i++)
      {   
        print("[" + (Node)getCell(i,j) + "]");     
      }
      println(" ");
  }*/
  //-------------debug-------------
    
    // TODO : Complétez ce code

    openList.add(start);
    
    
    while(openList.size() > 0)
    {
      //trouver le F le plus bas
    int lowestF = 0;
    for (int i = 0; i < openList.size(); i++) 
    {
      if ((openList.get(i).getH() +  openList.get(i).getG()) < (CurrentNode.getH() + CurrentNode.getG())) 
      {
        lowestF = i;
      }
    }
    CurrentNode = openList.get(lowestF);
      
      if(CurrentNode == end)// if (openSet[i].f < openSet[winner].f), winner = i
      {
        generatePath();
      }

     closedList.add(CurrentNode); //removeFromArray(openSet, current);
     openList.remove(CurrentNode); //closedSet.push(current);
     getLowestCost(openList);
     
     //verif voisin   
      
        Node Neighbors = null;
        for(int i = 0; i < CurrentNode.neighbours.size(); i++)
        {
            Neighbors = CurrentNode.neighbours.get(i);
            
            if(!closedList.contains(Neighbors) && Neighbors.isWalkable)
            {  
              int tempG = CurrentNode.getG() + 10;
              boolean newPath = false;
              
              if(openList.contains(Neighbors))
              {
                if (tempG < Neighbors.getG()) 
                {
                  Neighbors.setG(tempG);
                  newPath = true;
                }
              } else {
              
              Neighbors.setG(tempG);
              newPath = true;
              openList.add(Neighbors);
              }
              
              if(newPath) 
              {
                Neighbors.setH(calculateH(Neighbors));            
                Neighbors.parent = CurrentNode;
              }
            }
        }
    }
  }
  /*************************************************************************
  /*
    Permet de générer le chemin une fois trouvée
  */
  void generatePath () {
    // TODO : Complétez ce code
    Node cell = end;
    color c = color (55, 55, 55);
    
    while(cell.getParent() != null)
    {
      if(cell != end)
      {
        cell.setFillColor(c);
      }
      cell = cell.getParent();
    }
  }
  /****************************************************************************
  /**
  * Cherche et retourne le noeud le moins couteux de la liste ouverte
  * @return Node le moins couteux de la liste ouverte
  */
  private Node getLowestCost(ArrayList<Node> openList) {
    // TODO : Complétez ce code
    Node lessCostly = null;
    
    for(int i=0; i<openList.size(); i++){
      
        if (lessCostly == null){
        lessCostly = openList.get(i);
        }
        
        if(openList.get(i).getF() < lessCostly.getF()){
            lessCostly = openList.get(i);
        }
    }
    
    return lessCostly;
  }
  
/********************************************************************************
  
 /**
  * Calcule le coût de déplacement entre deux noeuds
  * @param nodeA Premier noeud
  * @param nodeB Second noeud
  * @return
  */
  private int calculateCost(Cell nodeA, Cell nodeB) {
    // TODO : Complétez ce code
    //int calcCost;//G'
    ////calcCost = nodeA.getG();
    return 10;
  }
  //******************************************************************************
  /**
  * Calcule l'heuristique entre le noeud donnée et le noeud finale
  * @param node Noeud que l'on calcule le H
  * @return la valeur H
  */
  private int calculateH(Cell node) {
    // TODO : Complétez ce code
    int dx = abs(node.i - end.i);
    int dy= abs(node.j - end.j);
    int D = 10;
   
    return D*(dy+dx);
  }
  
  //**************************************************************************************************
  
  String toStringFGH() {
    String result = "";
    
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {

        Node current = (Node)cells.get(j).get(i);
        
        result += "(" + current.getF() + ", " + current.getG() + ", " + current.getH() + ") ";
      }
      
      result += "\n";
    }
    
    return result;
  }
  
  //*******************************************************************************************************
  
  // Permet de créer un mur à la position _i, _j avec une longueur
  // et orientation données.
  void makeWall (int _i, int _j, int _length, boolean _vertical) {
    int max;
    
    if (_vertical) {
      max = _j + _length > rows ? rows: _j + _length;  
      
      for (int j = _j; j < max; j++) {
        ((Node)cells.get(j).get(_i)).setWalkable (false, 0);
      }       
    } else {
      max = _i + _length > cols ? cols: _i + _length;  
      
      for (int i = _i; i < max; i++) {
        ((Node)cells.get(_j).get(i)).setWalkable (false, 0);
      }     
    }
  }
}

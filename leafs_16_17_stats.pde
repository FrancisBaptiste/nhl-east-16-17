PFont font;
XML xml;
XML[] players;

void setup() {

  //load data
  xml = loadXML("stats.xml");

  noLoop();
  background(255);
  stroke(0);
  strokeWeight(1);
  noFill();
  font = createFont("Arial", 17, true);
  textFont(font, 13);
  size(1000, 800);
}

void draw() {
  fill(100);
  noFill();
  
  translate(width/4, 720);
  
  //draw the grid
  /*
  for(int i = 0; i < 90; i++){
    stroke(230);
    
    float thisY = 0 - (i * 10);
    line(0, thisY, 700, thisY);
    
    float thisX = 0 + (i*10);
    line(thisX, 0, thisX, -700);
  }
  */
  
    
  //create the lines and the text
  stroke(200);
  int lineLength = 10;
  float topHeight = -700;
  line(0,0, -lineLength,0);
  line(0,0,0, topHeight);
  line(0, topHeight, -lineLength, topHeight);
  
  //translate rotate, then rotate back and tralsate back
  translate(0, -330);
  float rad = radians(-90);
  rotate(rad);
  text("Goals", 330, -5);
  rad = radians(90);
  rotate(rad);
  translate(0, 330);
  
  float topWidth = 667;
  line(0,0, 0, lineLength);
  line(0,0,topWidth,0);
  line(topWidth, 0, topWidth, lineLength);
  text("Assists", 620, 15);
  
  
  //create the team stats
  
  players = xml.getChildren("leafs/player");
  stroke(57,83,164);
  drawStats(players, 0, 0);
  text("Leafs", -35, 70);
  
  players = xml.getChildren("bruins/player");
  stroke(120,70,150);
  drawStats(players, 85, 0);
  text("Bruins", 85-38, 70);
  
  players = xml.getChildren("senators/player");
  stroke(220,130,180);
  drawStats(players, 170, 0);
  text("Senators", 170-54, 70);
  
  players = xml.getChildren("rangers/player");
  stroke(120,190,110);
  drawStats(players, 255, 0);
  text("Rangers", 255-54, 70);
  
  players = xml.getChildren("habs/player");
  stroke(100,200,190);
  drawStats(players, 340, 0);
  text("Habs", 340-32, 70);
  
  players = xml.getChildren("blueJackets/player");
  stroke(240,230,90);
  drawStats(players, 425, 0);
  text("Blue Jackets", 425-72, 70);
  
  players = xml.getChildren("penguins/player");
  stroke(240,160,90);
  drawStats(players, 510, 0);
  text("Penguins", 510-57, 70);
  
  players = xml.getChildren("capitals/player");
  stroke(200,40,40);
  drawStats(players, 600, 0);
  text("Capitals", 600-54, 70);
  
  
  
}

void drawStats(XML[] players, int startPointX, int direction){
  
  for (int i = 0; i < players.length; i++) {
    String name = players[i].getChild("name").getContent();
    String goalsString = players[i].getChild("goals").getContent();
    String assistsString = players[i].getChild("assists").getContent();

    int goals = Integer.parseInt(goalsString);
    int assists = Integer.parseInt(assistsString);

    float multiplyer = 10;
    float curve = 25 + ( (goals * multiplyer) / 2);
    
    //this 0 used to be startPointX but that causes each draw to be independent, rather than mixed
    float assistX = 0 + (assists * multiplyer);
    if(direction == 1){
      assistX = startPointX - (assists * multiplyer);
    }
    float assistY = 0 - (goals * multiplyer);
    float assistBX = assistX;
    float assistBY = assistY - (curve);
    
    int points = goals + assists;
    
    int startPointY = 70;
    
    if(points > 0){
      bezier(startPointX, startPointY, startPointX, startPointY-curve, assistX, assistY, assistBX, assistBY);
    }
  
    /*
    //this is to visualize the bezier
    stroke(255, 0, 0);
    ellipse(0, 150, 2, 2);
    ellipse(0, 150-curve, 2, 2);
    line(0, 150, 0, 150-curve);
    ellipse(assistX, assistY, 2, 2);
    ellipse(assistBX, assistBY, 2, 2);
    line(assistX, assistY, assistBX, assistBY);
    */
    
  }
}


//for capturing the image
void mousePressed() {
  saveFrame("test-##.png");
}
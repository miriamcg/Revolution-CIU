PShape obj;
int x, y, x0, y0, z, sign;
float alpha;
boolean revolution, firstClick; 
ArrayList <Point> points;
PFont font;

void setup(){
  size(600, 600, P3D);
  background(0);
  
  font = loadFont("AgencyFB-Bold-48.vlw");
  
  firstClick = true;
  
  points = new ArrayList<Point>();
  
  z = 0;
  sign = 36;
  alpha = TWO_PI/sign;
}

void draw(){
  if(!revolution){
    drawingPoints();
    fill(255);
    textSize(16);
    text("Click any mouse button for drawing", width/2 - 290, height/2 - 240);
    text("outline of a figure", width/2 -290, height/2 - 220);
    text("Press ENTER to see the", width/2 - 290, height/2 - 180);
    text("solid of revolution of figure", width/2 -290, height/2 - 160);
  }else{
    background(0);
    fill(255);
    textSize(20);
    text("Press TAB key for drawing a new figure", width/2 - 200, height/2 - 250);
    drawingShape();
    translate(mouseX, mouseY - 160);
    shape(obj);
  }
}

void mouseClicked(){
  if(firstClick && mouseX >= width/2){
    x0 = mouseX;
    y0 = mouseY;
    Point p = new Point(x0, y0);
    points.add(p);
    firstClick = false;
  }
  
  if(mouseX >= width/2){
    x = mouseX;
    y = mouseY;
    Point p = new Point(x, y);
    points.add(p);
  }
}

void keyPressed(){
  if(key == ENTER){
    revolution = true;
  }
  if(key == TAB){
    points.clear();
    background(0);
    firstClick = true;
    revolution = false;
  }
}

void drawingPoints(){
  //línea divisoria
  stroke(255, 0, 0);
  line(width/2, 0, width/2, height);
  if (!firstClick) {
    point(x0, y0);
    stroke(255, 0, 0);
    line(x0, y0, x, y);
    x0 = x;
    y0 = y;
  }else{
    point(x, y);
  }
}

void drawingShape(){
  obj = createShape();
  obj.beginShape(TRIANGLE_STRIP);
  obj.fill(255);
  obj.stroke(255, 0, 0);
  obj.strokeWeight(2);
  for(int i = 0; i < points.size()-1; i++){
    Point p1 = points.get(i);
    Point p2 = points.get(i+1);
    for(int j = 0; j < sign; j++){
      obj.vertex(((p1.x - width/2)*cos(alpha*j)-(z*sin(alpha*j))), p1.y, ((p1.x - width/2)*sin(alpha*j)-(z*cos(alpha*j))));
      obj.vertex(((p2.x - width/2)*cos(alpha*j)-(z*sin(alpha*j))), p2.y, ((p2.x - width/2)*sin(alpha*j)-(z*cos(alpha*j))));
    }
  }
  obj.endShape(CLOSE);
}

class Point{
  
  int x;
  int y;
  
  Point(int tempX, int tempY){
    x = tempX;
    y = tempY;
  }
  
  String toString(){
    return "x " + x + " y " + y;
  }
}

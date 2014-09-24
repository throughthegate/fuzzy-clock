class HandCircle{
  float distance;
  float radius;
  float angleOffset;
  int myHue;
  int cx;
  int cy;
  PVector location;
  //directions
  float xDir;
  float yDir;
  int counter;
  
  HandCircle(int _cx, int _cy, float _distance, float _angleOffset, float _radius, int _myHue) {
    distance = _distance;
    angleOffset = _angleOffset;
    radius = _radius;
    myHue = _myHue;
    cx = _cx;
    cy = _cy;
  }
  
  void draw(float angle){
    float myAngle = angle + angleOffset;
    noStroke();
    fill(myHue,255,255);
    float mycx = cx + cos(myAngle) * distance;
    float mycy = cy + sin(myAngle) * distance;
    if(location == null){
      location = new PVector(mycx, mycy);
    }
    ellipse(location.x,location.y,radius,radius);    
  }
  
  PVector getLocation(){
    return location;
  }
  
  void update(float x, float y){
     noStroke();
     fill(myHue,255,255);
    ellipse(x, y, radius, radius);
    location.x = x;
    location.y = y; 
  }
  
}

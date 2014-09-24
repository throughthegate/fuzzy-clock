class Hand {
  float fuzziness; // in radians
  float radius;
  int numCircles;
  int myHue;
  float movement = 0.4; //how much the dots can move at once.
  int smallC = 7; //smallest cirlce size
  int largeC = 13; //largest circle size
  
  HandCircle circles[];
  
  Hand(float _radius, float _fuzziness, int _numCircles, int _myHue){
    radius = _radius;
    fuzziness = _fuzziness;
    numCircles = _numCircles;
    myHue = _myHue;
    
    // set up circles
    circles = new HandCircle[numCircles];
    for(int i = 0; i < numCircles; i++) {
      circles[i] = new HandCircle(cx, cy, random(10,100)/100.0*radius,
      random(-100,100)/100.0*fuzziness,random(smallC, largeC),(int)random(myHue-10,myHue+10));
    }
    
    
  }
  
  void draw(float angle){
    for(int i = 0; i < numCircles; i++){
      circles[i].draw(angle);
    }
    movement(angle);
  }
  
  //makes circles move a bit.
  void movement(float angle){
     for(int i = 0; i < numCircles; i++) {
       PVector location = circles[i].getLocation();
       float xRand = 0;
       float yRand = 0;
       int cx = circles[i].cx;
       int cy = circles[i].cy;
       
       //if adding the new location takes you outside the radius, then it's a no go.
       boolean outside = true;
   
       circles[i].counter = 0;
       while(outside == true){
          
          xRand = random(-movement, movement);
          yRand = random(-movement, movement);
          //calculate the new radial distance
          float radDist = sqrt((location.x - cx + xRand)*(location.x - cx + xRand) + (location.y - cy + yRand)*(location.y -cy + yRand));
         
          //calculate the new angle in radians
          float newAngle = acos((location.x - cx + xRand)/radDist);
          //account for negatives. Since I think the y axis goes opposite...but will it matter here?
          if(location.y - cy < 0){
             newAngle = -1 * newAngle; 
          }
          
          //calculate the offset angle
          float difference = abs(newAngle - angle)%TWO_PI;
          //if difference is bvigger than pi, we want to find the interior of it.
          if(difference > PI){
             difference = TWO_PI - difference; 
          }
      /*    
           println("difference for " + i + "is: " + difference);
          println("fuzzines is: " + fuzziness);
          println("");
      */
          //check to see if it's within the radius, and the radian sector
          if(circles[i].counter > 2){
              //after 3 tries...redraw the circle
              circles[i] = new HandCircle(cx, cy, random(10,100)/100.0*radius, 
                     random(-100,100)/100.0*fuzziness, random(smallC, largeC),(int)random(myHue-10,myHue+10));
              outside = false;
              circles[i].counter = 0;
              //println("NEW for #" + i);
          }
          else if( (radDist < radius) && (radDist > 0.1*radius) ){
                if((difference < fuzziness )){
                  circles[i].update(location.x + xRand, location.y + yRand);
                  outside = false;  
                  //println("circle " + i + " is inside");
                              
                }
                //else redraw a new circle
                else{
                  /* circles[i] = new HandCircle(cx, cy, random(10,100)/100.0*radius, 
                     random(-100,100)/100.0*fuzziness, random(smallC, largeC),(int)random(myHue-10,myHue+10));
                   outside = false;
                   */
                   outside = true;
                   circles[i].counter++;
                  
                   //println("circle " + i + " is outside");
                   
                }
          }
          else{
            outside = true;
            circles[i].counter++;
            /* 
                 circles[i] = new HandCircle(cx, cy, random(10,100)/100.0*radius, 
                     random(-100,100)/100.0*fuzziness, random(smallC, largeC),(int)random(myHue-10,myHue+10)); 
                 outside = false;
              */
              //just redraw a new circle.
              //println("LOOP for #" + i);
              //outside = true;
              
          }
       }
        /*  if( (radDist < radius) && (radDist > 0.1*radius)){
             if( (difference < fuzziness ) ) {
                 outside = false; 
              }
              else{ outside = true;}
          }
          //else it's outside the bounds, and needs to be done again. 
          else{
            outside = true;
          }
       }
       */
       
       //circles[i].update(location.x + xRand, location.y + yRand);
     }
  }
  
  
}

// adapted from clock example program from processing.org
// http://processing.org/examples/clock.html
// Thanks to Phoebe Sengers for starting the project code
// Richmond Wong, 2014

int cx, cy;
int mySat = 255;
int myBright = 200;
float minutesRadius;
float hoursRadius;
float clockDiameter;
Hand minuteHand;
Hand hourHand;

// color combination
int minuteHue = 30;
int hourHue = 210;
int markerHue = 125;

//USER SETTINGS
int windowWidth = 800; //width of window - 800 is usually good
int windowHeight = 800; //height of window - rec 800
float minuteFuzzy = 0.7; //fuziness of minute hand in radians
float hourFuzzy = 0.15; //fuzziness of the hour hand in radians
int numMinuteCircles = 75; //number of minute hand cicles
int numHourCircles = 30; //number of hour hand circles

void setup() {
  size(windowWidth, windowHeight);
  stroke(255);
  
  int radius = min(width, height) / 2;
  minutesRadius = radius * 0.75;
  hoursRadius = radius * 0.5;
  clockDiameter = radius * 1.8;
  
  //println("Radius: " + radius);
  //println("minutesRadius: " + minutesRadius);
  
  cx = int(width / 2);  
  cy = int(height / 2); 
  
  colorMode(HSB);
  
  //new Hand( hand radius, fuziness in radians, number of circles, hue)
  minuteHand = new Hand(minutesRadius, minuteFuzzy, numMinuteCircles, minuteHue);
  hourHand = new Hand(hoursRadius, hourFuzzy, numHourCircles, hourHue);
}

void draw() {
  background(000);
  
  // Draw the clock background
  // fill(200);
  // noStroke();
  // ellipse(cx, cy, clockDiameter, clockDiameter);
  
  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  
  // Draw the hands of the clock
//  stroke(80);
//  strokeWeight(2);
//  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
//  strokeWeight(4);
//  line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
  minuteHand.draw(m);
  hourHand.draw(h);
 
   
  // Draw the hour ticks
  fill(markerHue,mySat,255);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=30) {
    float angle = radians(a);
    float x = cx + cos(angle) * 0.45*clockDiameter;
    float y = cy + sin(angle) * 0.45*clockDiameter;
    ellipse(x, y,8,8);
  }
  endShape();

}


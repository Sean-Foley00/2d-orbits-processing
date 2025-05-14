import processing.sound.*;

class Body {
  private String name;
  private color col;
  private float size = 0; 
  private float a, b, cx, cy, orbitSpeed = 0;
  private float angle = 0; // cumulative angle change
  private int orbitCount = 0;
  private float x;
  private float y;
  
  /* offset all orbits */
  public static final int orbitOffsetX = 0;
  public static final int orbitOffsety = 0;
  
  private float totalTimeSeconds = this.calcTotalTimeSeconds();
  private float remainingTimeSeconds = 0;
  
  static final int bpm = 90;
  static final float framesPerBeat = 60 / (bpm / 60);
  /* 90beats_minute / 60seconds_minute = 1.5beats_second
     60frames_second / 1.5beats_seconds = 40 frames_beat */
  
  static final int fps = 60;
  private final float secondsPerFrame = 1 / fps;


  /* SETTER METHODS */
  
  public Body setName(String name) {
    this.name = name;
    return this;
  }
  
  public Body setCol(color col) {
    this.col = col;
    return this;
  }
  
  // body diameter
  public Body setSize(float size) {
    this.size = log(size + 2) * 3.5;
    return this;
  }
  
  // orbit width radius
  public Body setA(float a) {
    this.a = a * 0.8;
    return this;
  }
  
  // orbit height radius
  public Body setB(float b) {
    this.b = b * 0.9;
    return this;
  }
  
  // center of orbit x
  public Body setCX(float cx) {
    this.cx = cx + orbitOffsetX;
    return this;
  }
  
  // center of orbit y
  public Body setCY(float cy) {
    this.cy = cy;
    return this;
  }
  
  // degrees of rotation each frame
  public Body setOrbitSpeed(float orbitSpeed) {
    this.orbitSpeed = TWO_PI/(orbitSpeed * framesPerBeat);
    return this;
  }
  
  /* REAL METHODS */
  /* length of orbit in seconds */
  private float calcTotalTimeSeconds() {
    return secondsPerFrame * (TWO_PI / this.orbitSpeed);
  }
  
  /* total orbit minus elapsed orbit in seconds */
  private void calcRemainingTimeSeconds() {
   float elapsedTimeSeconds = secondsPerFrame * (this.angle % TWO_PI / this.orbitSpeed);
   this.remainingTimeSeconds = this.totalTimeSeconds - elapsedTimeSeconds;
  }
  
  private float calcPercentOrbit() {
    println(map(this.angle/TWO_PI,0,1,0,100));
    return map(this.angle/TWO_PI,0,1,0,100);
  }
  
  /* progress along orbit, update angle and time remaining */
  public void update() {
    if (min(this.a, this.b) > 0) {
      float newAngle = this.angle + this.orbitSpeed;
      if (newAngle >= TWO_PI)
        this.orbitCount = this.orbitCount + 1;
      this.angle = newAngle % TWO_PI;
      //this.calcRemainingTimeSeconds(); 
    }
  }
  
  /* display elliptical orbit, fill when body completes orbit */
  public void displayOrbit() {
    pushMatrix();
    translate(width/2, height/2);
    noFill();
    /* no Fill until first full orbit */
    if (this.orbitCount > 0)
      fill(255, map(this.angle, 0, TWO_PI, 55, 0));
    stroke(255, 75);
    strokeWeight(2);
    ellipse(this.cx, this.cy, this.a * 2, this.b * 2);
    popMatrix();
  }
  
  
  /* display body along orbit */
  public void display() {
    pushMatrix();
    translate(width/2, height/2); // center screen
    x = this.cx + this.a * cos(this.angle);
    y = this.cy + this.b * sin(this.angle);
    noStroke();
    fill(this.col);
    circle(x, y, this.size);
    popMatrix();
  }
  
}

/* Maths
Parametric equatio of an ellipse

x = cx + a * cos(t)
y = cy + b * sin(t)

t = angle parameter, from 0 to Tau (2 Pi)
cos(t) = x component
sin(t) = y component
a & b = scale value for eccentricity
cx & cy = offset for center point

Source: https://www.mathopenref.com/coordparamellipse.html
*/

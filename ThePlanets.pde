Body[] bodies = new Body[12];
boolean looping = false;

String outputStamp = year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + "-" + millis();

void setup() {
  size(1920, 1080);
  resetSketch();
  noLoop();
}

void draw() {
  background(0);
  
  for (int i = 0; i < bodies.length; i++) {
    bodies[i].displayOrbit();
    bodies[i].display();
    bodies[i].update();
  }
  
  //if(frameCount <= 216000)
  //  saveFrame("output/" + outputStamp + "/" + outputStamp + "_image####.png");
  //else
  //  exit();
}

void resetSketch() {
  frameRate(Body.fps);
  float halfW = width/2;
  float halfH = height/2;

  // "...,you must first create the universe."
  for (int i = 0; i < bodies.length; i++) {
    bodies[i] = new Body();
  }
  
  bodies[0].setName("Sol")     .setCol(color(255)) .setSize(294.118);
  // Create Bodies - Inner System
  bodies[1].setName("Mercury") .setCol(color(255)) .setSize(1)      .setA(halfW * 0.05) .setB(halfH * 0.05) .setOrbitSpeed(1);
  bodies[2].setName("Venus")   .setCol(color(255)) .setSize(2.529)  .setA(halfW * 0.075).setB(halfH * 0.075).setOrbitSpeed(2.5);
  bodies[3].setName("Earth")   .setCol(color(255)) .setSize(2.676)  .setA(halfW * 0.1)  .setB(halfH * 0.1)  .setOrbitSpeed(4);
  bodies[4].setName("Mars")    .setCol(color(255)) .setSize(1.412)  .setA(halfW * 0.125).setB(halfH * 0.125).setOrbitSpeed(7.75);
  // Create Bodies - Asteroid Belt
  bodies[5].setName("4 Vesta") .setCol(color(255)) .setSize(0.108)  .setA(halfW * 0.3)  .setB(halfH * 0.3)  .setOrbitSpeed(15);
  bodies[6].setName("Ceres")   .setCol(color(255)) .setSize(0.471)  .setA(halfW * 0.325).setB(halfH * 0.325).setOrbitSpeed(19);
  // Create Bodies - Outer System
  bodies[7].setName("Jupiter") .setCol(color(255)) .setSize(29.412) .setA(halfW * 0.45) .setB(halfH * 0.45) .setOrbitSpeed(47);
  bodies[8].setName("Saturn")  .setCol(color(255)) .setSize(24.706) .setA(halfW * 0.55) .setB(halfH * 0.55) .setOrbitSpeed(123);
  bodies[9].setName("Uranus")  .setCol(color(255)) .setSize(10)     .setA(halfW * 0.65) .setB(halfH * 0.65) .setOrbitSpeed(351);
  bodies[10].setName("Neptune").setCol(color(255)) .setSize(9.1)    .setA(halfW * 0.77) .setB(halfH * 0.77) .setOrbitSpeed(684);
  // Creater Bodies - Kuiper Belt
  bodies[11].setName("Pluto")  .setCol(color(255)) .setSize(0.487)  .setA(halfW * 0.95) .setB(halfH * 0.95) .setOrbitSpeed(1032.75);
}

void keyPressed() {
  switch(key) {
    case ENTER:
      if (looping) {
        noLoop();
        looping = false;
      } else {
        loop(); 
        looping = true;
      }
      break;
    case 'r':
    case 'R':
      looping = false;
      resetSketch();
      noLoop();
      redraw();
      break;
    default:
      break;
    } 
}

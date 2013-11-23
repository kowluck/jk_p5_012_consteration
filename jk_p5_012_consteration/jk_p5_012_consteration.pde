// Nov 2013
// http://jiyu-kenkyu.org
// http://kow-luck.com
//
// This work is licensed under a Creative Commons 3.0 License.
// (Attribution - NonCommerical - ShareAlike)
// http://creativecommons.org/licenses/by-nc-sa/3.0/
// 
// This basically means, you are free to use it as long as you:
// 1. give http://kow-luck.com a credit
// 2. don't use it for commercial gain
// 3. share anything you create with it in the same way I have
//
// If you want to use this work as more free, or encourage me,
// please contact me via http://kow-luck.com/contact

//========================================
import processing.opengl.*;

int NUM = 180;
float zView, zViewIncAng;
float s, t;
float Radius, RadIncAng;
float xPos, yPos, zPos, zRot;

Nodes[] nodes = new Nodes[NUM];

//========================================
void setup() {
  size(1280, 720, OPENGL);
  frameRate(30);

  for (int i= 0; i < NUM; i++) {
    nodes[i] = new Nodes(400);
  }
  Radius = 400;
  RadIncAng = 0;

  zView = -width/2;
  zViewIncAng = 0;
}

//========================================
void draw() {
  background(0);
  eyeMove();
  translate(width/2, 0, 0);
  rotateY(radians(mouseX/2) +frameCount * 0.004);
  //rotateX(radians(mouseY));
  pushMatrix();
  translate(width/4, height/2, 0);
  growMe();
  drawMe();
  popMatrix();
  printLine();
}

//========================================
void eyeMove() {
  translate(0, 0, zView);
  float rad = radians(zViewIncAng);
  zView += sin(rad) * 3;
  zViewIncAng += 0.3;
  if (zViewIncAng > 360) {
    zViewIncAng = 0;
  }
} 

//========================================
void growMe() {

  float rad = radians(RadIncAng);
  Radius += sin(rad) * 5;
  RadIncAng += 0.5;
  if (RadIncAng > 360) {
    RadIncAng = 0;
  }
}

//========================================
void drawMe() {
  s = 0;
  t = 0;
  for (int i = 0; i < NUM; i++) {   
    s += 18;  
    t += 1;   
    float radianS = radians(s);
    float radianT = radians(t);
    xPos = 0 + (Radius * cos(radianS) * sin(radianT));
    yPos = 0 + (Radius * sin(radianS) * sin(radianT));
    zPos = 0 + (Radius * cos(radianT) * noise(radianS));
    zRot = 2 * sin(radianT);

    pushMatrix();
    translate(xPos, yPos, zPos);
    rotateY(frameCount * -0.004 - radians(mouseX/2));
    //rotateX(-radians(mouseY));
    rotateZ(zRot);
    nodes[i].display();
    popMatrix();
  }
}

//========================================
void printLine() {
  println("Rad:" + round(Radius)
    +     " zView:" + round(zView)
    +     " FR:" + frameRate);
}


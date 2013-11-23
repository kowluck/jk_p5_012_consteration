public class Nodes {
  int NUM = 8;

  float[] xPos = new float[NUM];
  float[] yPos = new float[NUM];
  float[] xMov = new float[NUM];
  float[] yMov = new float[NUM];
  float[] circDia = new float[NUM];
  float[] circAlpha = new float[NUM];
  float[] cAInc = new float[NUM];

  float lineAlpha;

  float bounceArea;

  //======================== 
  Nodes(int _bounceArea) {

    bounceArea = _bounceArea;

    for (int i=0; i<NUM; i++) {
      xPos[i] = random(-bounceArea/2, bounceArea/2);
      yPos[i] = random(-bounceArea/2, bounceArea/2);
      xMov[i] = random(-4, 4);
      yMov[i] = random(-3, 3);
      circDia[i] = random(0.5, 1) * bounceArea / 20;
      circAlpha[i] = random(bounceArea/10, bounceArea);
      cAInc[i] = 5;
    }
    
  }

  //========================
  public void display() {
    colorMode(RGB, 255, 255, 255, bounceArea);
    this.drawMe();
    this.moveAndBounce();
  }

  //========================
  private void drawMe() {
    //blendMode(ADD);
    
    pushMatrix();

    for (int i = 1; i < NUM; i++) {
      for (int j = i; j < NUM; j++) {
        lineAlpha = bounceArea - (dist(xPos[i], yPos[i], xPos[j], yPos[j]) * 1.5);
        strokeWeight(1);
        stroke(255, 255, 255, lineAlpha);
        line(xPos[i], yPos[i], xPos[j], yPos[j]);
      }
     pushMatrix();
      circAlpha[i] += cAInc[i];
      noStroke();
      fill(255, circAlpha[i]);
      ellipse(xPos[i], yPos[i], circDia[i], circDia[i]);
      if (circAlpha[i] < bounceArea/10 ||circAlpha[i] > bounceArea) {
        cAInc[i] *= -1;
      }
      popMatrix();
    }
    popMatrix();
  }

  //========================
  private void moveAndBounce() {
    for (int i = 1; i < NUM; i++) {
      xPos[i] += xMov[i];
      yPos[i] += yMov[i];

      if (xPos[i] < -bounceArea/2 || xPos[i] > bounceArea/2) {
        xMov[i] *=-1;
      }
      if (yPos[i] < -bounceArea/2 || yPos[i] > bounceArea/2) {
        yMov[i] *=-1;
      }
    }
  }
}


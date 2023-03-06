class Switch {
  float x, y, sx, sy;
  PImage img;
  boolean prevPressed = false;
  boolean active = true, on = false;
  Switch(float x, float y, float sx) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    sy = sx/2;
  }
  Switch(float x, float y, float sx, String imgName) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    sy = sx/2;
    img = loadImage(dataPath(imgName));
    img.resize(int(sy), 0);
  }

  void display() {


    //base
    fill(0);
    stroke(0, 0);
    ellipse(x+sy/2, y+sy/2, sy, sy);
    ellipse(x+sy/2+sy, y+sy/2, sy, sy);
    rect(x+sy/2, y, sy, sy);
    if (on) {
      fill(#32E63C);
    } else {
      fill(#E92D2D);
    }
    ellipse(x+sy/2, y+sy/2, sy*0.8, sy*0.8);
    ellipse(x+sy/2+sy, y+sy/2, sy*0.8, sy*0.8);
    rect(x+sy/2, y+sy*0.1, sy, sy*0.8);

    fill(0);
    if (on) {
      if (img!=null) {
        ellipse(x+sy/2, y+sy/2, sy, sy);
        imageMode(CENTER);
        image(img, x+sy/2, y+sy/2);
        imageMode(CORNER);
      } else {
        ellipse(x+sy/2, y+sy/2, sy, sy);
        fill(128);
        ellipse(x+sy/2, y+sy/2, sy*0.8, sy*0.8);
      }
    } else {
      if (img!=null) {
        ellipse(x+sy+sy/2, y+sy/2, sy, sy);
        imageMode(CENTER);
        image(img, x+sy/2+sy, y+sy/2);
        imageMode(CORNER);
      } else {
        ellipse(x+sy+sy/2, y+sy/2, sy, sy);
        fill(128);
        ellipse(x+sy+sy/2, y+sy/2, sy*0.8, sy*0.8);
      }
    }

    //switch
    if (active&&mousePressed&&!prevPressed&&mouseX>x&&mouseX<x+sx&&mouseY>y&&mouseY<y+sy) {
      on = !on;
    }

    prevPressed = mousePressed;
  }
}

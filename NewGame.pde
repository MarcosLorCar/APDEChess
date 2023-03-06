class NewGame {
  float x, y, sx, sy;
  int count = 0;
  boolean prevPressed = false;
  boolean active = true, pressed = false;
  NewGame(float x, float y, float sx) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    sy = sx/2;
  }

  void display() {

    if (mousePressed&&mouseX>x&&mouseX<x+sx&&mouseY>y&&mouseY<y+sy) {
      if (!pressed&&mousePressed&&mouseX>x&&mouseX<x+sx&&mouseY>y&&mouseY<y+sy) {
        if (frameCount>(count+120)) {
          fill(200);
          ellipse(x+sy/2, y+sy/2, sy*4, sy*4);
          ellipse(x+sy/2+sy, y+sy/2, sy*4, sy*4);
          rect(x+sy/2, y-(sy/2)*3, sy, sy*4);
        }
        if (frameCount>(count+60)) {
          fill(150);
          ellipse(x+sy/2, y+sy/2, sy*3, sy*3);
          ellipse(x+sy/2+sy, y+sy/2, sy*3, sy*3);
          rect(x+sy/2, y-(sy/2)*2, sy, sy*3);
        }
        if (frameCount>(count)) {
          fill(100);
          ellipse(x+sy/2, y+sy/2, sy+sy, sy+sy);
          ellipse(x+sy/2+sy, y+sy/2, sy+sy, sy+sy);
          rect(x+sy/2, y-sy/2, sy, sy+sy);
        }
        if (frameCount>(count+180)) {
          pressed = true;
        }
      }
    } else {
      count = frameCount;
      pressed = false;
    }

    //base
    fill(0);
    stroke(0, 0);
    ellipse(x+sy/2, y+sy/2, sy, sy);
    ellipse(x+sy/2+sy, y+sy/2, sy, sy);
    rect(x+sy/2, y, sy, sy);
    fill(128);
    ellipse(x+sy/2, y+sy/2, sy*0.8, sy*0.8);
    ellipse(x+sy/2+sy, y+sy/2, sy*0.8, sy*0.8);
    rect(x+sy/2, y+sy*0.1, sy, sy*0.8);
    
    fill(0);
    rectMode(CENTER);
    rect(x+sy,y+sy/2,sy/2,sy/5);
    rect(x+sy,y+sy/2,sy/5,sy/2);
    rectMode(CORNER);

    prevPressed = mousePressed;
  }
}

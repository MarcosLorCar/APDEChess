class Clock {
  float x, y, sx, sy;
  boolean onTop, counted = false, count = false, active = true;
  long time = 36000;
  boolean noMinutes = false;

  Clock(float x, float y, float sx, boolean onTop) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    sy = sx/2;
    this.onTop = onTop;
  }

  void update() {
    if (active) {
      if (!counted) {
        stroke(0, 0);
        fill(#644707);
        float bx = x;
        float by, bsy;
        if (onTop) {
          by = y-sy/3;
          bsy = sy/3;
          if (time<212400) {
            ellipse(bx+bsy/2, by+bsy/2, bsy, bsy);
            ellipse(bx+sx/2-bsy/2, by+bsy/2, bsy, bsy);
            rect(bx, by+bsy/2, sx/2, bsy/2);
            rect(bx+bsy/2, by, sx/2-bsy, bsy);
            rectMode(CENTER);
            fill(255);
            rect(bx+sx/4, by+bsy/2, bsy/2, bsy/6);
            rect(bx+sx/4, by+bsy/2, bsy/6, bsy/2);
            rectMode(CORNER);
            fill(#644707);
            if (mousePressed&&!prevPressed&&mouseX>bx&&mouseX<bx+sx/2&&mouseY>by&&mouseY<by+bsy) {
              time+=3600;
            }
          }
          bx = x + sx/2;
          if (time>3600) {
            ellipse(bx+bsy/2, by+bsy/2, bsy, bsy);
            ellipse(bx+sx/2-bsy/2, by+bsy/2, bsy, bsy);
            rect(bx, by+bsy/2, sx/2, bsy/2);
            rect(bx+bsy/2, by, sx/2-bsy, bsy);
            rectMode(CENTER);
            fill(255);
            rect(bx+sx/4, by+bsy/2, bsy/2, bsy/6);
            rectMode(CORNER);
            fill(#644707);
          }
          if (time>3600&&mousePressed&&!prevPressed&&mouseX>bx&&mouseX<bx+sx/2&&mouseY>by&&mouseY<by+bsy) {
            time-=3600;
          }
        } else {
          by = y+sy;
          bsy = sy/3;
          if (time<212400) {
            ellipse(bx+bsy/2, by+bsy/2, bsy, bsy);
            ellipse(bx+sx/2-bsy/2, by+bsy/2, bsy, bsy);
            rect(bx, by, sx/2, bsy/2);
            rect(bx+bsy/2, by, sx/2-bsy, bsy);
            rectMode(CENTER);
            fill(255);
            rect(bx+sx/4, by+bsy/2, bsy/2, bsy/6);
            rect(bx+sx/4, by+bsy/2, bsy/6, bsy/2);
            rectMode(CORNER);
            fill(#644707);
            if (mousePressed&&!prevPressed&&mouseX>bx&&mouseX<bx+sx/2&&mouseY>by&&mouseY<by+bsy) {
              time+=3600;
            }
          }
          bx = x + sx/2;
          if (time>3600) {
            ellipse(bx+bsy/2, by+bsy/2, bsy, bsy);
            ellipse(bx+sx/2-bsy/2, by+bsy/2, bsy, bsy);
            rect(bx, by, sx/2, bsy/2);
            rect(bx+bsy/2, by, sx/2-bsy, bsy);
            rectMode(CENTER);
            fill(255);
            rect(bx+sx/4, by+bsy/2, bsy/2, bsy/6);
            rectMode(CORNER);
          }
          if (time>3600&&mousePressed&&!prevPressed&&mouseX>bx&&mouseX<bx+sx/2&&mouseY>by&&mouseY<by+bsy) {
            time-=3600;
          }
        }
      }

      if (count&&time>0) {
        time-=1;
      }

      if (count&&time<0) {
        count = false;
      }
      display();
    }
  }

  void display() {

    String cents = str(int(((time%60)*100)/60));
    if (int(((time%60)*100)/60)<10) {
      cents="0"+str(int(((time%60)*100)/60));
    }
    if (int(((time%60)*100)/60)<=0) {
      cents="00";
    }
    String secs = str(int((time/60)%60));
    if (int(((time/60)%60))<10) {
      secs="0"+str(int((time/60)%60));
    }
    if (int(((time/60)%60))<=0) {
      secs="00";
    }
    String mins = str(int((time/3600)%60));
    if (int(((time/3600)%60))<10) {
      mins="0"+str(int((time/3600)%60));
    }
    if (int(((time/3600)%60))<=0) {
      mins="00";
    }


    float by = sy/5;
    if (onTop&&counted) {

      //clock
      fill(#644707);
      ellipse(x+sx-by/2, y+by/2, by, by);
      ellipse(x+by/2, y+by/2, by, by);
      rect(x+by/2, y, sx-by, sy);
      rect(x,y+by/2, sx, sy-by/2);
      fill(0);
      ellipse(x+sx-by, y+by, by, by);
      ellipse(x+by, y+by, by, by);
      rect(x+by/2, y+by, sx-by, sy-by);
      rect(x+by, y+by/2, sx-by*2, sy-by*2);
      
    } else if (!onTop&&counted) {

      fill(#644707);
      ellipse(x+sx-by/2, y+sy-by/2, by, by);
      ellipse(x+by/2, y+sy-by/2, by, by);
      rect(x, y, sx, sy-by/2);
      rect(x+by/2, y, sx-by, sy);
      fill(0);
      ellipse(x+sx-by, y+sy-by, by, by);
      ellipse(x+by, y+sy-by, by, by);
      rect(x+by/2, y, sx-by, sy-by);
      rect(x+by, y, sx-by*2, sy-by/2);
      
    } else if (onTop&&!counted) {

      fill(#644707);
      rect(x, y, sx, sy);
      fill(0);
      ellipse(x+sx-by, y+by, by, by);
      ellipse(x+by, y+by, by, by);
      rect(x+by/2, y+by, sx-by, sy-by);
      rect(x+by, y+by/2, sx-by*2, sy-by*2);
    } else if(!counted) {

      fill(#644707);
      rect(x, y, sx, sy);
      fill(0);
      ellipse(x+sx-by, y+sy-by, by, by);
      ellipse(x+by, y+sy-by, by, by);
      rect(x+by/2, y, sx-by, sy-by);
      rect(x+by, y, sx-by*2, sy-by/2);
    }

    //numbers
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(3*(sy/5));
    if (int((time/3600)%60)<=0) {
      text(secs, x+sy/2, y+sy/2);
      text(cents, x+sx-sy/2, y+sy/2);
    } else {
      text(mins, x+sy/2, y+sy/2);
      text(secs, x+sx-sy/2, y+sy/2);
    }
    text(":", x+sx/2, y+sy/2.2);
  }
}

class SwitchMenu {
  PImage icon;
  ArrayList<Switch> switches;
  boolean open = false, active = true;
  float x, y, sx, sy;
  SwitchMenu(float x, float y, float sx, String menuIcon) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    sy = sx/2;
    switches = new ArrayList<Switch>();
    icon = loadImage(menuIcon);
    icon.resize(int(sy), int(sy));
  }
  
  boolean isOn(int i) {
    return switches.get(i).on;
  }

  void addSwitch() {
    switches.add(new Switch(x, y+(sy/5+sy)*(switches.size()+1), sx));
  }

  void addSwitch(int j) {
    for (int i = 0; i<j; i++) {
      switches.add(new Switch(x, y+(sy/5+sy)*(switches.size()+1), sx));
    }
  }

  void addSwitch(String img) {
    switches.add(new Switch(x, y+(sy/5+sy)*(switches.size()+1), sx, img));
  }

  void addSwitch(int j, String[] imgs) {
    for (int i = 0; i<j; i++) {
      switches.add(new Switch(x, y+(sy/5+sy)*(switches.size()+1), sx, imgs[i]));
    }
  }

  void update() {
    if (active) {
      float msy = sy+(sy+sy/5)*switches.size();
      if (open) {
        fill(0);
        stroke(0, 0);
        ellipse(x+sy/2, y+sy/2, sy, sy);
        ellipse(x+sy/2+sy, y+sy/2, sy, sy);
        ellipse(x+sy/2, y+msy-sy/2, sy, sy);
        ellipse(x+sy/2+sy, y+msy-sy/2, sy, sy);
        rect(x+sy/2, y, sy, msy);
        rect(x, y+sy/2, sx, msy-sy);
        fill(255);
        ellipse(x+sy/2, y+sy/2, sy*0.8, sy*0.8);
        ellipse(x+sy/2+sy, y+sy/2, sy*0.8, sy*0.8);
        rect(x+sy/2, y+sy*0.1, sy, sy*0.8);
        if (switches.size()>0) {
          for (int i = 0; i<switches.size(); i++) {
            switches.get(i).display();
          }
        }
      } else {
        fill(0);
        stroke(0, 0);
        ellipse(x+sy/2, y+sy/2, sy, sy);
        ellipse(x+sy/2+sy, y+sy/2, sy, sy);
        rect(x+sy/2, y, sy, sy);
        fill(255);
        ellipse(x+sy/2, y+sy/2, sy*0.8, sy*0.8);
        ellipse(x+sy/2+sy, y+sy/2, sy*0.8, sy*0.8);
        rect(x+sy/2, y+sy*0.1, sy, sy*0.8);
      }

      imageMode(CENTER);
      image(icon, x+sx/2, y+sy/2);
      if (mousePressed&&!prevPressed) {
        if (mouseX>x&&mouseX<x+sx&&mouseY>y&&mouseY<y+sy) {
          open=!open;
        } else if(!(mouseX>x&&mouseX<x+sx&&mouseY>y&&mouseY<y+msy)) {
          open = false;
        }
      }
    }
  }
}

import processing.sound.*;

SoundFile moveSFX, captureSFX;
SwitchMenu sm;
Board bd;
boolean prevPressed = false;
NewGame newGame;

void settings() {
  fullScreen();
}

void setup() {
  moveSFX = new SoundFile(this, dataPath("move.wav"));
  captureSFX = new SoundFile(this, dataPath("capture.wav"));
  newGame = new NewGame(width-30-width/5, 30, width/5);
  sm = new SwitchMenu(30,30,width/5,dataPath("gear.png"));
  sm.addSwitch(dataPath("clock.png"));
  sm.addSwitch(dataPath("swap.png"));
  sm.switches.get(0).on = true;
  sm.addSwitch(dataPath("perspective.png"));
  bd = new Board((width/8/5), (height/2-width/2)+(width/8)/5, width-2*(width/8)/5, true);
}

void draw() {
  background(#095200);

  if (newGame.pressed||(bd.bmate||bd.wmate)&&!prevPressed&&mousePressed&&mouseX>bd.x&&mouseX<bd.x+bd.size*8&&mouseY>bd.y&&mouseY<bd.y+bd.size*8) {
    bd = new Board(bd.x, bd.y, bd.size*8, false);
    bd.setPieces();
    prevPressed=true;
    bd.saveBoard();
  }
  
  if((frameCount%60)==0) {
    bd.saveBoard();
  }
  
  //move
  bd.wmate = true;
  bd.bmate = true;
  for (int i = 0; i<8; i++) {
    for (int j = 0; j<8; j++) {
      if (bd.pieces[i][j]!=null&&bd.pieces[i][j].white&&bd.pieces[i][j].moves()[0].size()>0) {
        bd.bmate = false;
      }
    }
  }
  for (int i = 0; i<8; i++) {
    for (int j = 0; j<8; j++) {
      if (bd.pieces[i][j]!=null&&!bd.pieces[i][j].white&&bd.pieces[i][j].moves()[0].size()>0) {
        bd.wmate = false;
      }
    }
  }
  
  if(bd.wclock.active&&bd.wclock.time<=0) {
    bd.bmate = true;
  }
  if(bd.bclock.active&&bd.bclock.time<=0) {
    bd.wmate = true;
  }

  if (bd.turn||!sm.switches.get(1).on) {
    bd.display();
  } else {
    bd.displayInv();
  }

  if (!(bd.wmate||bd.bmate)) {
    if (bd.promoting==null&&bd.movPiece!=null) {
      if (bd.turn||!sm.switches.get(1).on) {
        bd.highlight(bd.movPiece, 0, 180, 75, false);
      } else {
        bd.highlightInv(bd.movPiece, 0, 180, 75, false);
      }
    }
    int[] movement = null;
    boolean castled = false;
    if ((bd.turn||!sm.switches.get(1).on)&&bd.promoting==null&&bd.selected) {
      bd.highlight(bd.selPiece, 0, 200, 100, true);
      fill(0, 200, 100,128);
      for (int i = 0; i<bd.selPiece.moves()[0].size(); i++) {
        float movx = bd.x+(bd.selPiece.moves()[0].get(i)*bd.size);
        float movy = bd.y+(bd.selPiece.moves()[1].get(i)*bd.size);
        ellipse(movx+(bd.size/2), movy+(bd.size/2), bd.size/3, bd.size/3);
        if (bd.getTile()!=null&&mousePressed&&!prevPressed) {
          if ((mouseX>(movx))&&(mouseX<(movx+bd.size))&&(mouseY>(movy))&&(mouseY<(movy+bd.size))) {
            bd.movPiece = bd.selPiece;
            movement = new int[]{bd.selPiece.moves()[0].get(i), bd.selPiece.moves()[1].get(i)};
            if (bd.selPiece.canCastle&&bd.selPiece.type==1) {
              if (bd.selPiece.white) {
                if (bd.selPiece.moves()[0].get(i)==2) {
                  castled = true;
                }
                if (bd.selPiece.moves()[0].get(i)==6) {
                  castled = true;
                }
              } else {
                if (bd.selPiece.moves()[0].get(i)==2) {
                  castled = true;
                }
                if (bd.selPiece.moves()[0].get(i)==6) {
                  castled = true;
                }
              }
            }
            bd.turn=!bd.turn;
            if (bd.turn) {
              bd.bclock.counted = true;
              bd.wclock.counted = true;
              bd.bclock.count = false;
              bd.wclock.count = true;
            } else if (!bd.turn) {
              bd.bclock.counted = true;
              bd.wclock.counted = true;
              bd.bclock.count = true;
              bd.wclock.count = false;
            }
          } else {
            bd.selected = false;
          }
        }
      }
      if (movement!=null) {
        if (castled) {
          if (bd.selPiece.white) {
            if (movement[0]>4) {
              bd.movePiece(bd.pieces[7][7], 5, 7);
            } else {
              bd.movePiece(bd.pieces[7][0], 3, 7);
            }
          } else {
            if (movement[0]>4) {
              bd.movePiece(bd.pieces[0][7], 5, 0);
            } else {
              bd.movePiece(bd.pieces[0][0], 3, 0);
            }
          }
        }
        if(bd.pieces[movement[1]][movement[0]]!=null) {
          captureSFX.play();
        } else {
          moveSFX.play();
        }
        bd.movePiece(bd.movPiece, movement[0], movement[1]);
        prevPressed = mousePressed;
        bd.selected=false;
        if (bd.movPiece.type==0) {
          if ((bd.pieces[movement[1]][movement[0]].white&&movement[1]==0)||(!bd.pieces[movement[1]][movement[0]].white&&movement[1]==7)) {
            bd.promoting = bd.pieces[movement[1]][movement[0]];
          }
        }
        bd.saveBoard();
      }
    } else if (sm.switches.get(1).on&&bd.promoting==null&&bd.selected) {
      bd.highlightInv(bd.selPiece, 0, 200, 100, true);
      fill(0, 200, 100,128);
      for (int i = 0; i<bd.selPiece.moves()[0].size(); i++) {
        float movx = bd.x+((7-bd.selPiece.moves()[0].get(i))*bd.size);
        float movy = bd.y+((7-bd.selPiece.moves()[1].get(i))*bd.size);
        ellipse(movx+(bd.size/2), movy+(bd.size/2), bd.size/3, bd.size/3);
        if (bd.getTileInv()!=null&&mousePressed&&!prevPressed) {
          if ((mouseX>(movx))&&(mouseX<(movx+bd.size))&&(mouseY>(movy))&&(mouseY<(movy+bd.size))) {
            bd.movPiece = bd.selPiece;
            movement = new int[]{bd.selPiece.moves()[0].get(i), bd.selPiece.moves()[1].get(i)};
            if (bd.selPiece.canCastle&&bd.selPiece.type==1) {
              if (bd.selPiece.white) {
                if (bd.selPiece.moves()[0].get(i)==2) {
                  castled = true;
                }
                if (bd.selPiece.moves()[0].get(i)==6) {
                  castled = true;
                }
              } else {
                if (bd.selPiece.moves()[0].get(i)==2) {
                  castled = true;
                }
                if (bd.selPiece.moves()[0].get(i)==6) {
                  castled = true;
                }
              }
            }
            bd.turn=!bd.turn;
            if (bd.turn) {
              bd.bclock.counted = true;
              bd.wclock.counted = true;
              bd.bclock.count = false;
              bd.wclock.count = true;
            } else if (!bd.turn) {
              bd.bclock.counted = true;
              bd.wclock.counted = true;
              bd.bclock.count = true;
              bd.wclock.count = false;
            }
          } else {
            bd.selected = false;
          }
        }
      }
      if (movement!=null) {
        if (castled) {
          if (bd.selPiece.white) {
            if (movement[0]>4) {
              bd.movePiece(bd.pieces[7][7], 5, 7);
            } else {
              bd.movePiece(bd.pieces[7][0], 3, 7);
            }
          } else {
            if (movement[0]>4) {
              bd.movePiece(bd.pieces[0][7], 5, 0);
            } else {
              bd.movePiece(bd.pieces[0][0], 3, 0);
            }
          }
        }
        if(bd.pieces[movement[1]][movement[0]]!=null) {
          captureSFX.play();
        } else {
          moveSFX.play();
        }
        bd.movePiece(bd.movPiece, movement[0], movement[1]);
        prevPressed = mousePressed;
        bd.selected=false;
        if (bd.movPiece.type==0) {
          if ((bd.pieces[movement[1]][movement[0]].white&&movement[1]==0)||(!bd.pieces[movement[1]][movement[0]].white&&movement[1]==7)) {
            bd.promoting = bd.pieces[movement[1]][movement[0]];
          }
        }
        bd.saveBoard();
      }
    }
    if ((bd.turn||!sm.switches.get(1).on)&&bd.promoting==null&&bd.getTile()!=null&&(mousePressed)&&!prevPressed&&(bd.pieces[bd.getTile()[0]][bd.getTile()[1]]!=null)) {
      Piece tryPiece = bd.pieces[bd.getTile()[0]][bd.getTile()[1]];
      if (tryPiece.white==bd.turn&&tryPiece.moves()[0].size()>0) {
        bd.selPiece = tryPiece;
        bd.selected = true;
      }
    } else if (sm.switches.get(1).on&&bd.promoting==null&&bd.getTileInv()!=null&&(mousePressed)&&!prevPressed&&(bd.pieces[bd.getTileInv()[0]][bd.getTileInv()[1]]!=null)) {
      Piece tryPiece = bd.pieces[bd.getTileInv()[0]][bd.getTileInv()[1]];
      if (tryPiece.white==bd.turn&&tryPiece.moves()[0].size()>0) {
        bd.selPiece = tryPiece;
        bd.selected = true;
      }
    }

    if (!bd.wclock.counted&&!bd.bclock.counted) {
      if (sm.switches.get(0).on) {
        bd.wclock.active = true;
        bd.bclock.active = true;
      } else {
        bd.wclock.active = false;
        bd.bclock.active = false;
      }
    }
  }
  
  newGame.display();
  sm.update();

  prevPressed = mousePressed;
}

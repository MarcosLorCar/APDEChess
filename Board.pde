class Board {
  String[] save;
  Clock wclock, bclock;
  Piece[][] pieces;
  boolean wmate = false, bmate = false, prevMate= false;
  boolean selected = false;
  boolean turn = true;
  float x, y, size;
  Piece promoting;
  Piece selPiece;
  Piece movPiece;
  PImage iwpawn, iwking, iwqueen, iwbishop, iwknight, iwtower, ibpawn, ibking, ibqueen, ibbishop, ibknight, ibtower, swking, sbking, mwking, mbking, pwqueen, pbqueen, pwtower, pbtower, pwbishop, pbbishop, pwknight, pbknight, wpawn, bpawn, wtower, btower, wknight, bknight, wbishop, bbishop, wqueen, bqueen, wking, bking;
  Board(float x, float y, float size, boolean load) {
    pieces = new Piece[8][8];
    this.size = size/8;
    this.x = x;
    this.y = y;
    loadImgs();
    if (load) {
      loadBoard();
    } else {
      setPieces();
    }
  }

  void saveBoard() {
    save = new String[75];
    String line;
    int index = 0;
    if (wclock.active) {
      line = "1";
    } else {
      line = "0";
    }
    if (wclock.count) {
      line += "1";
    } else {
      line += "0";
    }
    if (wclock.counted) {
      line += "1";
    } else {
      line += "0";
    }
    line += str(int(wclock.time));
    save[index] = line;
    index++;

    if (bclock.active) {
      line = "1";
    } else {
      line = "0";
    }
    if (bclock.count) {
      line += "1";
    } else {
      line += "0";
    }
    if (bclock.counted) {
      line += "1";
    } else {
      line += "0";
    }
    line += str(int(bclock.time));
    save[index] = line;
    index++;

    if (wmate) {
      line = "1";
    } else {
      line = "0";
    }
    save[index] = line;
    index++;

    if (bmate) {
      line = "1";
    } else {
      line = "0";
    }
    save[index] = line;
    index++;

    if (selected) {
      line = "1";
    } else {
      line = "0";
    }
    save[index] = line;
    index++;

    if (turn) {
      line = "1";
    } else {
      line = "0";
    }
    save[index] = line;
    index++;

    if (promoting!=null) {
      line = promoting.getData();
    } else {
      line = "0";
    }
    save[index] = line;
    index++;

    if (selPiece!=null) {
      line = selPiece.getData();
    } else {
      line = "0";
    }
    save[index] = line;
    index++;

    if (movPiece!=null) {
      line = movPiece.getData();
    } else {
      line = "0";
    }
    save[index] = line;
    index++;

    for (int i = 0; i<8; i++) {
      for (int j = 0; j<8; j++) {
        if (pieces[i][j]!=null) {
          save[index] = pieces[i][j].getData();
        } else {
          save[index] = "0";
        }
        index++;
      }
    }
    save[index] = str(int(sm.switches.get(1).on));
    index++;
    save[index] = str(int(sm.switches.get(2).on));
    saveStrings(dataPath("board.txt"), save);
  }

  void loadBoard() {
    File f = new File(dataPath("board.txt"));
    if (f.exists()) {
      save = loadStrings(dataPath("board.txt"));
      int i = 0;
      wclock = new Clock(x+((size*8)/3)*2+(size/5), y+size*8, (size*8)/3, false);
      wclock.active = boolean(int(str(save[i].charAt(0))));
      wclock.count = boolean(int(str(save[i].charAt(1))));
      wclock.counted = boolean(int(str(save[i].charAt(2))));
      String wt = (save[i].substring(3));
      i++;
      bclock = new Clock(x+((size*8)/3)*2+(size/5), y+size*8, (size*8)/3, false);
      bclock.active = boolean(int(str(save[i].charAt(0))));
      bclock.count = boolean(int(str(save[i].charAt(1))));
      bclock.counted = boolean(int(str(save[i].charAt(2))));
      String bt = (save[i].substring(3));
      wclock.time = int(wt);
      bclock.time = int(bt);
      i++;
      if (int(save[i])==1) {
        wmate = true;
      }
      i++;
      if (int(save[i])==1) {
        bmate = true;
      }
      i++;
      if (int(save[i])==1) {
        selected = true;
      }
      i++;
      if (int(save[i])==1) {
        turn = true;
      } else {
        turn = false;
      }
      i++;
      if (int(str(save[i].charAt(0)))==1) {
        promoting = new Piece(int(str(save[i].charAt(1))), int(str(save[i].charAt(2))), this, int(str(save[i].charAt(3))), boolean(int(str(save[i].charAt(4)))), boolean(int(str(save[i].charAt(5)))), boolean(int(str(save[i].charAt(6)))));
      }
      i++;
      if (int(str(save[i].charAt(0)))==1) {
        selPiece = new Piece(int(str(save[i].charAt(1))), int(str(save[i].charAt(2))), this, int(str(save[i].charAt(3))), boolean(int(str(save[i].charAt(4)))), boolean(int(str(save[i].charAt(5)))), boolean(int(str(save[i].charAt(6)))));
      }
      i++;
      if (int(str(save[i].charAt(0)))==1) {
        movPiece = new Piece(int(str(save[i].charAt(1))), int(str(save[i].charAt(2))), this, int(str(save[i].charAt(3))), boolean(int(str(save[i].charAt(4)))), boolean(int(str(save[i].charAt(5)))), boolean(int(str(save[i].charAt(6)))));
      }
      i++;
      for (int j = 0; j<8; j++) {
        for (int k = 0; k<8; k++) {
          if (int(str(save[i].charAt(0)))==1) {
            pieces[j][k] = new Piece(int(str(save[i].charAt(1))), int(str(save[i].charAt(2))), this, int(str(save[i].charAt(3))), boolean(int(str(save[i].charAt(4)))), boolean(int(str(save[i].charAt(5)))), boolean(int(str(save[i].charAt(6)))));
          }
          i++;
        }
      }
      if (int(save[i])==1) {
        sm.switches.get(1).on = true;
      }
      i++;
      if (int(save[i])==1) {
        sm.switches.get(2).on = true;
      }
    } else {
      setPieces();
    }
  }

  void setPieces() {
    bclock = new Clock(x+((size*8)/3)*2+(size/5), y-(size*8)/6, (size*8)/3, true);
    wclock = new Clock(x+((size*8)/3)*2+(size/5), y+size*8, (size*8)/3, false);
    for (int i = 0; i<8; i++) {
      for (int j = 0; j<8; j++) {
        pieces[i][j] = null;
        if (layout[i][j]<6) {
          if (i<=3) {
            pieces[i][j] = new Piece(j, i, this, layout[i][j], false, false, true);
          } else {
            pieces[i][j] = new Piece(j, i, this, layout[i][j], true, false, true);
          }
          pieces[i][j].canCastle=true;
        }
      }
    }
  }

  int[][] layout = {
    {5, 4, 3, 2, 1, 3, 4, 5}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {6, 6, 6, 6, 6, 6, 6, 6}, 
    {6, 6, 6, 6, 6, 6, 6, 6}, 
    {6, 6, 6, 6, 6, 6, 6, 6}, 
    {6, 6, 6, 6, 6, 6, 6, 6}, 
    {0, 0, 0, 0, 0, 0, 0, 0}, 
    {5, 4, 3, 2, 1, 3, 4, 5}
  };


  void loadImgs() {

    swking = loadImage("wking.png");
    swking.resize(int(size*3), 0);
    sbking = loadImage("bking.png");
    sbking.resize(int(size*3), 0);

    mwking = loadImage("wking.png");
    mwking.resize(int(size*7), 0);
    mbking = loadImage("bking.png");
    mbking.resize(int(size*7), 0);

    pwqueen = loadImage("wqueen.png");
    pwqueen.resize(int(size*3), 0);
    pbqueen = loadImage("bqueen.png");
    pbqueen.resize(int(size*3), 0);

    pwtower = loadImage("wtower.png");
    pwtower.resize(int(size*3), 0);
    pbtower = loadImage("btower.png");
    pbtower.resize(int(size*3), 0);

    pwbishop = loadImage("wbishop.png");
    pwbishop.resize(int(size*3), 0);
    pbbishop = loadImage("bbishop.png");
    pbbishop.resize(int(size*3), 0);

    pwknight = loadImage("wknight.png");
    pwknight.resize(int(size*3), 0);
    pbknight = loadImage("bknight.png");
    pbknight.resize(int(size*3), 0);

    wpawn = loadImage("wpawn.png");
    wpawn.resize(int(size*0.9), 0);
    bpawn = loadImage("bpawn.png");
    bpawn.resize(int(size*0.9), 0);

    wtower = loadImage("wtower.png");
    wtower.resize(int(size*0.9), 0);
    btower = loadImage("btower.png");
    btower.resize(int(size*0.9), 0);

    wknight = loadImage("wknight.png");
    wknight.resize(int(size*0.9), 0);
    bknight = loadImage("bknight.png");
    bknight.resize(int(size*0.9), 0);

    wking = loadImage("wking.png");
    wking.resize(int(size*0.9), 0);
    bking = loadImage("bking.png");
    bking.resize(int(size*0.9), 0);

    wqueen = loadImage("wqueen.png");
    wqueen.resize(int(size*0.9), 0);
    bqueen = loadImage("bqueen.png");
    bqueen.resize(int(size*0.9), 0);

    wbishop = loadImage("wbishop.png");
    wbishop.resize(int(size*0.9), 0);
    bbishop = loadImage("bbishop.png");
    bbishop.resize(int(size*0.9), 0);
    
    iwpawn = loadImage("iwpawn.png");
    iwpawn.resize(int(size*0.9), 0);
    ibpawn = loadImage("ibpawn.png");
    ibpawn.resize(int(size*0.9), 0);

    iwtower = loadImage("iwtower.png");
    iwtower.resize(int(size*0.9), 0);
    ibtower = loadImage("ibtower.png");
    ibtower.resize(int(size*0.9), 0);

    iwknight = loadImage("iwknight.png");
    iwknight.resize(int(size*0.9), 0);
    ibknight = loadImage("ibknight.png");
    ibknight.resize(int(size*0.9), 0);

    iwking = loadImage("iwking.png");
    iwking.resize(int(size*0.9), 0);
    ibking = loadImage("ibking.png");
    ibking.resize(int(size*0.9), 0);

    iwqueen = loadImage("iwqueen.png");
    iwqueen.resize(int(size*0.9), 0);
    ibqueen = loadImage("ibqueen.png");
    ibqueen.resize(int(size*0.9), 0);

    iwbishop = loadImage("iwbishop.png");
    iwbishop.resize(int(size*0.9), 0);
    ibbishop = loadImage("ibbishop.png");
    ibbishop.resize(int(size*0.9), 0);
  }

  Board(Piece[][] setup) {
    pieces = setup;
  }

  void movePiece(Piece pc, int nx, int ny) {
    if (!((nx==pc.bx)&&(ny==pc.by))) {
      pieces[ny][nx] = new Piece(nx, ny, this, pc.type, pc.white, pc.twice);
      if (pc.type==0&&pc.white&&pieces[ny+1][nx]!=null&&pieces[ny+1][nx].twice) {
        pieces[ny+1][nx] = null;
      }
      if (pc.type==0&&!pc.white&&pieces[ny-1][nx]!=null&&pieces[ny-1][nx].twice) {
        pieces[ny-1][nx] = null;
      }
      for (int i = 0; i<8; i++) {
        for (int j = 0; j<8; j++) {
          if (pieces[i][j]!=null) {
            pieces[i][j].twice=false;
          }
        }
      }
      if (pc.type==0&&((ny-pc.by==2)||(pc.by-ny==2))) {
        pieces[ny][nx].twice = true;
      }
      pieces[pc.by][pc.bx] = null;
    }
  }

  int[] getTile() {
    int[] tile = null;
    float tx, ty;
    for (int i = 0; i<8; i++) {
      for (int j = 0; j<8; j++) {
        tx = x+size*j;
        ty = y+size*i;
        if ((mouseX>tx)&&(mouseX<tx+size)&&(mouseY>ty)&&(mouseY<ty+size)) {
          tile = new int[]{i, j};
        }
      }
    }
    return tile;
  }

  int[] getTileInv() {
    int[] tile = null;
    float tx, ty;
    for (int i = 0; i<8; i++) {
      for (int j = 0; j<8; j++) {
        tx = x+size*(7-j);
        ty = y+size*(7-i);
        if ((mouseX>tx)&&(mouseX<tx+size)&&(mouseY>ty)&&(mouseY<ty+size)) {
          tile = new int[]{i, j};
        }
      }
    }
    return tile;
  }

  boolean isLegal(boolean check, Piece pc, int nx, int ny) {
    if ((pc.bx>=0&&pc.bx<=7&&pc.by>=0&&pc.by<=7)&&(nx>=0&&nx<=7&&ny>=0&&ny<=7)&&((pieces[ny][nx]==null)||(pieces[ny][nx]!=null&&pc.white!=pieces[ny][nx].white)||((pc.bx==nx)&&(pc.by==ny)))) {
      if (pc.type==0&&pieces[ny][nx]!=null&&pc.bx==nx) {
        return false;
      } else if (pc.type==0&&pieces[ny][nx]==null&&pc.bx!=nx) {
        if (pc.white) {
          if (pieces[ny+1][nx]!=null&&pieces[ny+1][nx].twice) {
            if (check) {
              return true;
            } else {
              boolean isCheck = false;
              Board tryBoard = new Board(new Piece[8][8]);
              for (int i = 0; i<8; i++) {
                for (int j = 0; j<8; j++) {
                  if (pc.board.pieces[i][j]!=null) {
                    tryBoard.pieces[i][j] = new Piece(pc.board.pieces[i][j].bx, pc.board.pieces[i][j].by, tryBoard, pc.board.pieces[i][j].type, pc.board.pieces[i][j].white, pc.board.pieces[i][j].twice);
                  }
                }
              }

              tryBoard.movePiece(tryBoard.pieces[pc.by][pc.bx], nx, ny);


              for (int i = 0; i<8; i++) {
                for (int j = 0; j<8; j++) {
                  if (tryBoard.pieces[i][j]!=null&&tryBoard.pieces[i][j].white!=pc.white&&tryBoard.pieces[i][j].isChecking(tryBoard)) {
                    isCheck = true;
                  }
                }
              }
              return !isCheck;
            }
          } else {
            return false;
          }
        } else {
          if (pieces[ny-1][nx]!=null&&pieces[ny-1][nx].twice) {
            if (check) {
              return true;
            } else {
              boolean isCheck = false;
              Board tryBoard = new Board(new Piece[8][8]);
              for (int i = 0; i<8; i++) {
                for (int j = 0; j<8; j++) {
                  if (pc.board.pieces[i][j]!=null) {
                    tryBoard.pieces[i][j] = new Piece(pc.board.pieces[i][j].bx, pc.board.pieces[i][j].by, tryBoard, pc.board.pieces[i][j].type, pc.board.pieces[i][j].white, pc.board.pieces[i][j].twice);
                  }
                }
              }

              tryBoard.movePiece(tryBoard.pieces[pc.by][pc.bx], nx, ny);


              for (int i = 0; i<8; i++) {
                for (int j = 0; j<8; j++) {
                  if (tryBoard.pieces[i][j]!=null&&tryBoard.pieces[i][j].white!=pc.white&&tryBoard.pieces[i][j].isChecking(tryBoard)) {
                    isCheck = true;
                  }
                }
              }
              return !isCheck;
            }
          } else {
            return false;
          }
        }
      } else {
        if (check) {
          return true;
        } else {
          boolean isCheck = false;
          Board tryBoard = new Board(new Piece[8][8]);
          for (int i = 0; i<8; i++) {
            for (int j = 0; j<8; j++) {
              if (pc.board.pieces[i][j]!=null) {
                tryBoard.pieces[i][j] = new Piece(pc.board.pieces[i][j].bx, pc.board.pieces[i][j].by, tryBoard, pc.board.pieces[i][j].type, pc.board.pieces[i][j].white, pc.board.pieces[i][j].twice);
              }
            }
          }

          tryBoard.movePiece(tryBoard.pieces[pc.by][pc.bx], nx, ny);


          for (int i = 0; i<8; i++) {
            for (int j = 0; j<8; j++) {
              if (tryBoard.pieces[i][j]!=null&&tryBoard.pieces[i][j].white!=pc.white&&tryBoard.pieces[i][j].isChecking(tryBoard)) {
                isCheck = true;
              }
            }
          }
          return !isCheck;
        }
      }
    } else {
      return false;
    }
  }

  void highlight(Piece pc, int r, int g, int b, boolean show) {
    fill(r, g, b);
    rect(x+pc.bx*size, y+pc.by*size, size, size);
    if (show) {
      pc.display(pc.x, pc.y);
    }
  }
  void highlightInv(Piece pc, int r, int g, int b, boolean show) {
    fill(r, g, b);
    rect(x+(7-pc.bx)*size, y+(7-pc.by)*size, size, size);
    if (show) {
      pc.display(x+(size/2)+(7-pc.bx)*size, y+(size/2)+(7-pc.by)*size);
    }
  }

  void display() {
    if (wclock!=null) {
      wclock.y = y+size*8;
      wclock.onTop = false;
      wclock.update();
      bclock.y = y-(size*8)/6;
      bclock.onTop = true;
      bclock.update();
    }

    stroke(0, 0);
    fill(#644707);
    rect(x-(size/5), y-(size/5), size*8+2*(size/5), size*8+2*(size/5));
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        if ((i+j)%2!=0) {
          fill(255);
          rect(x+j*size, y+i*size, size, size);
          fill(0, 128);
        } else {
          fill(255);
          rect(x+j*size, y+i*size, size, size);
          fill(0, 50);
        }
        rect(x+j*size, y+i*size, size, size);
        if (pieces[i][j]!=null) {
          if(pieces[i][j].white) {
            pieces[i][j].display(pieces[i][j].x, pieces[i][j].y);
          } else {
            pieces[i][j].display(pieces[i][j].x, pieces[i][j].y);
          }
        }
      }
    }
    if (promoting!=null) {
      imageMode(CENTER);
      if (promoting.white) {
        fill(0, 150);
        rect(x, y, size*8, size*8);
        image(pwqueen, x+size*2, y+size*2);
        image(pwbishop, x+size*6, y+size*2);
        image(pwtower, x+size*2, y+size*6);
        image(pwknight, x+size*6, y+size*6);
      } else {
        fill(255, 150);
        rect(x, y, size*8, size*8);
        image(pbqueen, x+size*2, y+size*2);
        image(pbbishop, x+size*6, y+size*2);
        image(pbtower, x+size*2, y+size*6);
        image(pbknight, x+size*6, y+size*6);
      }
      if (!prevPressed&&mousePressed&&mouseX>x&&mouseX<x+size*4&&mouseY>y&&mouseY<y+size*4) {
        pieces[promoting.by][promoting.bx].type = 2;
        promoting = null;
      }
      if (!prevPressed&&mousePressed&&mouseX>x+size*4&&mouseX<x+size*8&&mouseY>y&&mouseY<y+size*4) {
        pieces[promoting.by][promoting.bx].type = 3;
        promoting = null;
      }
      if (!prevPressed&&mousePressed&&mouseX>x&&mouseX<x+size*4&&mouseY>y+size*4&&mouseY<y+size*8) {
        pieces[promoting.by][promoting.bx].type = 5;
        promoting = null;
      }
      if (!prevPressed&&mousePressed&&mouseX>x+size*4&&mouseX<x+size*8&&mouseY>y+size*4&&mouseY<y+size*8) {
        pieces[promoting.by][promoting.bx].type = 4;
        promoting = null;
      }
    }
    if (wmate) {
      if (!prevMate) {
        captureSFX.play();
      }
      boolean staleMate = true;
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (pieces[i][j]!=null&&pieces[i][j].white&&pieces[i][j].isChecking(this)) {
            staleMate = false;
          }
        }
      }
      if(bclock.time<=0) {
        staleMate = false;
      }
      if (staleMate) {
        fill(128, 150);
        rect(x, y, size*8, size*8);
        imageMode(CENTER);
        image(sbking, x+size*2, y+size*4);
        image(swking, x+size*6, y+size*4);
      } else {
        fill(0, 150);
        rect(x, y, size*8, size*8);
        imageMode(CENTER);
        image(mwking, x+size*4, y+size*4);
      }
      wclock.count=false;
      bclock.count=false;
    }
    if (bmate) {
      if (!prevMate) {
        captureSFX.play();
      }
      boolean staleMate = true;
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (pieces[i][j]!=null&&!pieces[i][j].white&&pieces[i][j].isChecking(this)) {
            staleMate = false;
          }
        }
      }
      if(wclock.time<=0) {
        staleMate = false;
      }
      if (staleMate) {
        fill(128, 150);
        rect(x, y, size*8, size*8);
        imageMode(CENTER);
        image(sbking, x+size*2, y+size*4);
        image(swking, x+size*6, y+size*4);
      } else {
        fill(255, 150);
        rect(x, y, size*8, size*8);
        imageMode(CENTER);
        image(mbking, x+size*4, y+size*4);
      }
      wclock.count=false;
      bclock.count=false;
    }
    prevMate = bmate||wmate;
  }

  void displayInv() {
    if (wclock!=null) {
      bclock.y = y+size*8;
      bclock.onTop = false;
      bclock.update();
      wclock.y = y-(size*8)/6;
      wclock.onTop = true;
      wclock.update();
    }
    stroke(0, 0);
    fill(#644707);
    rect(x-(size/5), y-(size/5), size*8+2*(size/5), size*8+2*(size/5));
    for (int i=7; i>=0; i--) {
      for (int j=7; j>=0; j--) {
        if ((i+j)%2!=0) {
          fill(255);
          rect(x+j*size, y+i*size, size, size);
          fill(0, 128);
        } else {
          fill(255);
          rect(x+j*size, y+i*size, size, size);
          fill(0, 50);
        }
        rect(x+j*size, y+i*size, size, size);
        if (pieces[7-i][7-j]!=null) {
          if(pieces[7-i][7-j].white) {
            pieces[7-i][7-j].display(x+(size/2)+j*size, y+(size/2)+i*size);
          } else {
            pieces[7-i][7-j].display(x+(size/2)+j*size, y+(size/2)+i*size);
          }
        }
      }
    }
    if (promoting!=null) {
      imageMode(CENTER);
      if (promoting.white) {
        fill(0, 150);
        rect(x, y, size*8, size*8);
        image(pwqueen, x+size*2, y+size*2);
        image(pwbishop, x+size*6, y+size*2);
        image(pwtower, x+size*2, y+size*6);
        image(pwknight, x+size*6, y+size*6);
      } else {
        fill(255, 150);
        rect(x, y, size*8, size*8);
        image(pbqueen, x+size*2, y+size*2);
        image(pbbishop, x+size*6, y+size*2);
        image(pbtower, x+size*2, y+size*6);
        image(pbknight, x+size*6, y+size*6);
      }
      if (!prevPressed&&mousePressed&&mouseX>x&&mouseX<x+size*4&&mouseY>y&&mouseY<y+size*4) {
        pieces[promoting.by][promoting.bx].type = 2;
        promoting = null;
      }
      if (!prevPressed&&mousePressed&&mouseX>x+size*4&&mouseX<x+size*8&&mouseY>y&&mouseY<y+size*4) {
        pieces[promoting.by][promoting.bx].type = 3;
        promoting = null;
      }
      if (!prevPressed&&mousePressed&&mouseX>x&&mouseX<x+size*4&&mouseY>y+size*4&&mouseY<y+size*8) {
        pieces[promoting.by][promoting.bx].type = 5;
        promoting = null;
      }
      if (!prevPressed&&mousePressed&&mouseX>x+size*4&&mouseX<x+size*8&&mouseY>y+size*4&&mouseY<y+size*8) {
        pieces[promoting.by][promoting.bx].type = 4;
        promoting = null;
      }
    }
    if (wmate) {
      if (!prevMate) {
        captureSFX.play();
      }
      boolean staleMate = true;
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (pieces[i][j]!=null&&pieces[i][j].white&&pieces[i][j].isChecking(this)) {
            staleMate = false;
          }
        }
      }
      if(bclock.time<=0) {
        staleMate = false;
      }
      if (staleMate) {
        fill(128, 150);
        rect(x, y, size*8, size*8);
        imageMode(CENTER);
        image(sbking, x+size*2, y+size*4);
        image(swking, x+size*6, y+size*4);
      } else {
        fill(0, 150);
        rect(x, y, size*8, size*8);
        imageMode(CENTER);
        image(mwking, x+size*4, y+size*4);
      }
      wclock.count=false;
      bclock.count=false;
    }
    if (bmate) {
      if (!prevMate) {
        captureSFX.play();
      }
      boolean staleMate = true;
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (pieces[i][j]!=null&&!pieces[i][j].white&&pieces[i][j].isChecking(this)) {
            staleMate = false;
          }
        }
      }
      if(wclock.time<=0) {
        staleMate = false;
      }
      if (staleMate) {
        fill(128, 150);
        rect(x, y, size*8, size*8);
        imageMode(CENTER);
        image(sbking, x+size*2, y+size*4);
        image(swking, x+size*6, y+size*4);
      } else {
        fill(255, 150);
        rect(x, y, size*8, size*8);
        imageMode(CENTER);
        image(mbking, x+size*4, y+size*4);
      }
      wclock.count=false;
      bclock.count=false;
    }
    prevMate = bmate||wmate;
  }
}

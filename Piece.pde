class Piece {
  boolean moving = false;
  Board board;
  float x, y, size;
  int type, bx, by;
  boolean white, twice = false, canCastle = true;

  Piece(int bx, int by, Board board, int type, boolean white, boolean twice) {
    canCastle = false;
    this.twice = twice;
    this.bx = bx;
    this.by = by;
    this.board = board;
    this.white = white;
    this.size = board.size;
    this.x = board.x+board.size/2+board.size*bx;
    this.y = board.y+board.size/2+board.size*by;
    this.type = type;
  }

  Piece(int bx, int by, Board board, int type, boolean white, boolean twice, boolean canCastle) {
    canCastle = false;
    this.twice = twice;
    this.bx = bx;
    this.by = by;
    this.board = board;
    this.white = white;
    this.size = board.size;
    this.x = board.x+board.size/2+board.size*bx;
    this.y = board.y+board.size/2+board.size*by;
    this.type = type;
    this.canCastle = canCastle;
  }

  String getData() {
    String data = "1";
    data += str(bx);
    data += str(by);
    data += int(type);
    if (white) {
      data += "1";
    } else {
      data += "0";
    }
    if (twice) {
      data += "1";
    } else {
      data += "0";
    }
    if (canCastle) {
      data += "1";
    } else {
      data += "0";
    }
    return data;
  }

  boolean isChecking(Board board) {
    IntList[] moves = new IntList[2];
    moves[0] = new IntList();
    moves[1] = new IntList();
    int temp = 1;
    boolean ate = false;
    switch(type) {
    case 0:
      if (white) {
        if (board.isLegal(true, this, bx-1, by-1)) {
          moves[0].append(bx-1);
          moves[1].append(by-1);
        }
        if (board.isLegal(true, this, bx+1, by-1)) {
          moves[0].append(bx+1);
          moves[1].append(by-1);
        }
      } else {
        if (board.isLegal(true, this, bx-1, by+1)) {
          moves[0].append(bx-1);
          moves[1].append(by+1);
        }
        if (board.isLegal(true, this, bx+1, by+1)) {
          moves[0].append(bx+1);
          moves[1].append(by+1);
        }
      }
      break;
    case 1:
      if (board.isLegal(true, this, bx-1, by-1)) {
        moves[0].append(bx-1);
        moves[1].append(by-1);
      }
      if (board.isLegal(true, this, bx, by-1)) {
        moves[0].append(bx);
        moves[1].append(by-1);
      }
      if (board.isLegal(true, this, bx+1, by-1)) {
        moves[0].append(bx+1);
        moves[1].append(by-1);
      }
      if (board.isLegal(true, this, bx-1, by)) {
        moves[0].append(bx-1);
        moves[1].append(by);
      }
      if (board.isLegal(true, this, bx+1, by)) {
        moves[0].append(bx+1);
        moves[1].append(by);
      }
      if (board.isLegal(true, this, bx-1, by+1)) {
        moves[0].append(bx-1);
        moves[1].append(by+1);
      }
      if (board.isLegal(true, this, bx, by+1)) {
        moves[0].append(bx);
        moves[1].append(by+1);
      }
      if (board.isLegal(true, this, bx+1, by+1)) {
        moves[0].append(bx+1);
        moves[1].append(by+1);
      }
      break;
    case 4:
      if (board.isLegal(true, this, bx-1, by-2)) {
        moves[0].append(bx-1);
        moves[1].append(by-2);
      }
      if (board.isLegal(true, this, bx+1, by-2)) {
        moves[0].append(bx+1);
        moves[1].append(by-2);
      }
      if (board.isLegal(true, this, bx-1, by+2)) {
        moves[0].append(bx-1);
        moves[1].append(by+2);
      }
      if (board.isLegal(true, this, bx+1, by+2)) {
        moves[0].append(bx+1);
        moves[1].append(by+2);
      }
      if (board.isLegal(true, this, bx-2, by-1)) {
        moves[0].append(bx-2);
        moves[1].append(by-1);
      }
      if (board.isLegal(true, this, bx-2, by+1)) {
        moves[0].append(bx-2);
        moves[1].append(by+1);
      }
      if (board.isLegal(true, this, bx+2, by-1)) {
        moves[0].append(bx+2);
        moves[1].append(by-1);
      }
      if (board.isLegal(true, this, bx+2, by+1)) {
        moves[0].append(bx+2);
        moves[1].append(by+1);
      }
      break;
    case 5:
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx, by-temp)&&!ate) {
        moves[0].append(bx);
        moves[1].append(by-temp);
        if (board.pieces[by-temp][bx]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx, by+temp))&&!ate) {
        moves[0].append(bx);
        moves[1].append(by+temp);
        if (board.pieces[by+temp][bx]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx-temp, by))&&!ate) {
        moves[0].append(bx-temp);
        moves[1].append(by);
        if (board.pieces[by][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx+temp, by))&&!ate) {
        moves[0].append(bx+temp);
        moves[1].append(by);
        if (board.pieces[by][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      break;
    case 3:
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx-temp, by-temp)&&!ate) {
        moves[0].append(bx-temp);
        moves[1].append(by-temp);
        if (board.pieces[by-temp][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx+temp, by+temp))&&!ate) {
        moves[0].append(bx+temp);
        moves[1].append(by+temp);
        if (board.pieces[by+temp][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx-temp, by+temp))&&!ate) {
        moves[0].append(bx-temp);
        moves[1].append(by+temp);
        if (board.pieces[by+temp][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx+temp, by-temp))&&!ate) {
        moves[0].append(bx+temp);
        moves[1].append(by-temp);
        if (board.pieces[by-temp][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      break;
    case 2:
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx, by-temp)&&!ate) {
        moves[0].append(bx);
        moves[1].append(by-temp);
        if (board.pieces[by-temp][bx]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx, by+temp))&&!ate) {
        moves[0].append(bx);
        moves[1].append(by+temp);
        if (board.pieces[by+temp][bx]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx-temp, by))&&!ate) {
        moves[0].append(bx-temp);
        moves[1].append(by);
        if (board.pieces[by][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx+temp, by))&&!ate) {
        moves[0].append(bx+temp);
        moves[1].append(by);
        if (board.pieces[by][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx-temp, by-temp)&&!ate) {
        moves[0].append(bx-temp);
        moves[1].append(by-temp);
        if (board.pieces[by-temp][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx+temp, by+temp))&&!ate) {
        moves[0].append(bx+temp);
        moves[1].append(by+temp);
        if (board.pieces[by+temp][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx-temp, by+temp))&&!ate) {
        moves[0].append(bx-temp);
        moves[1].append(by+temp);
        if (board.pieces[by+temp][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while ((board.isLegal(true, this, bx+temp, by-temp))&&!ate) {
        moves[0].append(bx+temp);
        moves[1].append(by-temp);
        if (board.pieces[by-temp][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      break;
    }
    boolean check = false;
    if (moves[0].size()>0) {
      for (int i = 0; i<moves[0].size(); i++) {
        if (board.pieces[moves[1].get(i)][moves[0].get(i)]!=null&&board.pieces[moves[1].get(i)][moves[0].get(i)].type==1&&white!=board.pieces[moves[1].get(i)][moves[0].get(i)].white) {
          check = true;
        }
      }
    }
    return check;
  }

  IntList[] moves() {
    IntList[] moves = new IntList[2];
    moves[0] = new IntList();
    moves[1] = new IntList();
    int temp = 1;
    boolean ate = false;
    switch(type) {
    case 0:
      if (white) {
        if (board.isLegal(false, this, bx, by-1)) {
          moves[0].append(bx);
          moves[1].append(by-1);
        }
        if (by==6&&board.isLegal(false, this, bx, by-2)&&board.isLegal(true, this, bx, by-1)) {
          moves[0].append(bx);
          moves[1].append(by-2);
        }
        if (board.isLegal(false, this, bx-1, by-1)) {
          moves[0].append(bx-1);
          moves[1].append(by-1);
        }
        if (board.isLegal(false, this, bx+1, by-1)) {
          moves[0].append(bx+1);
          moves[1].append(by-1);
        }
      } else {
        if (board.isLegal(false, this, bx, by+1)) {
          moves[0].append(bx);
          moves[1].append(by+1);
        }
        if (by==1&&board.isLegal(false, this, bx, by+2)&&board.isLegal(true, this, bx, by+1)) {
          moves[0].append(bx);
          moves[1].append(by+2);
        }
        if (board.isLegal(false, this, bx-1, by+1)) {
          moves[0].append(bx-1);
          moves[1].append(by+1);
        }
        if (board.isLegal(false, this, bx+1, by+1)) {
          moves[0].append(bx+1);
          moves[1].append(by+1);
        }
      }
      break;
    case 1:
      if (canCastle&&board.isLegal(false, this, bx, by)) {
        if (white&&board.pieces[7][7]!=null&&board.pieces[7][7].canCastle&&board.isLegal(false, this, bx+1, by)&&board.isLegal(false, this, bx+2, by)) {
          moves[0].append(bx+2);
          moves[1].append(by);
        }
        if (white&&board.pieces[7][0]!=null&&board.pieces[7][0].canCastle&&board.isLegal(false, this, bx-1, by)&&board.isLegal(false, this, bx-2, by)) {
          moves[0].append(bx-2);
          moves[1].append(by);
        }
        if (!white&&board.pieces[0][7]!=null&&board.pieces[0][7].canCastle&&board.isLegal(false, this, bx+1, by)&&board.isLegal(false, this, bx+2, by)) {
          moves[0].append(bx+2);
          moves[1].append(by);
        }
        if (!white&&board.pieces[0][0]!=null&&board.pieces[0][0].canCastle&&board.isLegal(false, this, bx-1, by)&&board.isLegal(false, this, bx-2, by)) {
          moves[0].append(bx-2);
          moves[1].append(by);
        }
      }
      if (board.isLegal(false, this, bx-1, by-1)) {
        moves[0].append(bx-1);
        moves[1].append(by-1);
      }
      if (board.isLegal(false, this, bx, by-1)) {
        moves[0].append(bx);
        moves[1].append(by-1);
      }
      if (board.isLegal(false, this, bx+1, by-1)) {
        moves[0].append(bx+1);
        moves[1].append(by-1);
      }
      if (board.isLegal(false, this, bx-1, by)) {
        moves[0].append(bx-1);
        moves[1].append(by);
      }
      if (board.isLegal(false, this, bx+1, by)) {
        moves[0].append(bx+1);
        moves[1].append(by);
      }
      if (board.isLegal(false, this, bx-1, by+1)) {
        moves[0].append(bx-1);
        moves[1].append(by+1);
      }
      if (board.isLegal(false, this, bx, by+1)) {
        moves[0].append(bx);
        moves[1].append(by+1);
      }
      if (board.isLegal(false, this, bx+1, by+1)) {
        moves[0].append(bx+1);
        moves[1].append(by+1);
      }
      break;
    case 4:
      if (board.isLegal(false, this, bx-1, by-2)) {
        moves[0].append(bx-1);
        moves[1].append(by-2);
      }
      if (board.isLegal(false, this, bx+1, by-2)) {
        moves[0].append(bx+1);
        moves[1].append(by-2);
      }
      if (board.isLegal(false, this, bx-1, by+2)) {
        moves[0].append(bx-1);
        moves[1].append(by+2);
      }
      if (board.isLegal(false, this, bx+1, by+2)) {
        moves[0].append(bx+1);
        moves[1].append(by+2);
      }
      if (board.isLegal(false, this, bx-2, by-1)) {
        moves[0].append(bx-2);
        moves[1].append(by-1);
      }
      if (board.isLegal(false, this, bx-2, by+1)) {
        moves[0].append(bx-2);
        moves[1].append(by+1);
      }
      if (board.isLegal(false, this, bx+2, by-1)) {
        moves[0].append(bx+2);
        moves[1].append(by-1);
      }
      if (board.isLegal(false, this, bx+2, by+1)) {
        moves[0].append(bx+2);
        moves[1].append(by+1);
      }
      break;
    case 5:
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx, by-temp)&&!ate) {
        if (board.isLegal(false, this, bx, by-temp)) {
          moves[0].append(bx);
          moves[1].append(by-temp);
        }
        if (board.pieces[by-temp][bx]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx, by+temp)&&!ate) {
        if (board.isLegal(false, this, bx, by+temp)) {
          moves[0].append(bx);
          moves[1].append(by+temp);
        }
        if (board.pieces[by+temp][bx]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx-temp, by)&&!ate) {
        if (board.isLegal(false, this, bx-temp, by)) {
          moves[0].append(bx-temp);
          moves[1].append(by);
        }
        if (board.pieces[by][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx+temp, by)&&!ate) {
        if (board.isLegal(false, this, bx+temp, by)) {
          moves[0].append(bx+temp);
          moves[1].append(by);
        }
        if (board.pieces[by][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      break;
    case 3:
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx-temp, by-temp)&&!ate) {
        if (board.isLegal(false, this, bx-temp, by-temp)) {
          moves[0].append(bx-temp);
          moves[1].append(by-temp);
        }
        if (board.pieces[by-temp][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx+temp, by+temp)&&!ate) {
        if (board.isLegal(false, this, bx+temp, by+temp)) {
          moves[0].append(bx+temp);
          moves[1].append(by+temp);
        }
        if (board.pieces[by+temp][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx-temp, by+temp)&&!ate) {
        if (board.isLegal(false, this, bx-temp, by+temp)) {
          moves[0].append(bx-temp);
          moves[1].append(by+temp);
        }
        if (board.pieces[by+temp][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx+temp, by-temp)&&!ate) {
        if (board.isLegal(false, this, bx+temp, by-temp)) {
          moves[0].append(bx+temp);
          moves[1].append(by-temp);
        }
        if (board.pieces[by-temp][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      break;
    case 2:
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx, by-temp)&&!ate) {
        if (board.isLegal(false, this, bx, by-temp)) {
          moves[0].append(bx);
          moves[1].append(by-temp);
        }
        if (board.pieces[by-temp][bx]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx, by+temp)&&!ate) {
        if (board.isLegal(false, this, bx, by+temp)) {
          moves[0].append(bx);
          moves[1].append(by+temp);
        }
        if (board.pieces[by+temp][bx]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx-temp, by)&&!ate) {
        if (board.isLegal(false, this, bx-temp, by)) {
          moves[0].append(bx-temp);
          moves[1].append(by);
        }
        if (board.pieces[by][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx+temp, by)&&!ate) {
        if (board.isLegal(false, this, bx+temp, by)) {
          moves[0].append(bx+temp);
          moves[1].append(by);
        }
        if (board.pieces[by][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx-temp, by-temp)&&!ate) {
        if (board.isLegal(false, this, bx-temp, by-temp)) {
          moves[0].append(bx-temp);
          moves[1].append(by-temp);
        }
        if (board.pieces[by-temp][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx+temp, by+temp)&&!ate) {
        if (board.isLegal(false, this, bx+temp, by+temp)) {
          moves[0].append(bx+temp);
          moves[1].append(by+temp);
        }
        if (board.pieces[by+temp][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx-temp, by+temp)&&!ate) {
        if (board.isLegal(false, this, bx-temp, by+temp)) {
          moves[0].append(bx-temp);
          moves[1].append(by+temp);
        }
        if (board.pieces[by+temp][bx-temp]!=null) {
          ate = true;
        }
        temp++;
      }
      temp = 1;
      ate = false;
      while (board.isLegal(true, this, bx+temp, by-temp)&&!ate) {
        if (board.isLegal(false, this, bx+temp, by-temp)) {
          moves[0].append(bx+temp);
          moves[1].append(by-temp);
        }
        if (board.pieces[by-temp][bx+temp]!=null) {
          ate = true;
        }
        temp++;
      }
      break;
    }
    return moves;
  }



  void display(float x, float y) {
    imageMode(CENTER);
    if (sm.isOn(2)&&sm.isOn(1)) {
      switch(type) {
      case 0:
        if (white) {
          if(white==board.turn) {
            image(board.wpawn, x, y);
          } else {
            image(board.iwpawn, x, y);
          }
        } else {
          if(white==board.turn) {
            image(board.bpawn, x, y);
          } else {
            image(board.ibpawn, x, y);
          }
        }
        break;
      case 1:
        if (white) {
          if(white==board.turn) {
            image(board.wking, x, y);
          } else {
            image(board.iwking, x, y);
          }
        } else {
          if(white==board.turn) {
            image(board.bking, x, y);
          } else {
            image(board.ibking, x, y);
          }
        }
        break;
      case 2:
        if (white) {
          if(white==board.turn) {
            image(board.wqueen, x, y);
          } else {
            image(board.iwqueen, x, y);
          }
        } else {
          if(white==board.turn) {
            image(board.bqueen, x, y);
          } else {
            image(board.ibqueen, x, y);
          }
        }
        break;
      case 3:
        if (white) {
          if(white==board.turn) {
            image(board.wbishop, x, y);
          } else {
            image(board.iwbishop, x, y);
          }
        } else {
          if(white==board.turn) {
            image(board.bbishop, x, y);
          } else {
            image(board.ibbishop, x, y);
          }
        }
        break;
      case 4:
        if (white) {
          if(white==board.turn) {
            image(board.wknight, x, y);
          } else {
            image(board.iwknight, x, y);
          }
        } else {
          if(white==board.turn) {
            image(board.bknight, x, y);
          } else {
            image(board.ibknight, x, y);
          }
        }
        break;
      case 5:
        if (white) {
          if(white==board.turn) {
            image(board.wtower, x, y);
          } else {
            image(board.iwtower, x, y);
          }
        } else {
          if(white==board.turn) {
            image(board.btower, x, y);
          } else {
            image(board.ibtower, x, y);
          }
        }
        break;
      }
    } else if (sm.isOn(2)) {
      switch(type) {
      case 0:
        if (white) {
          image(board.wpawn, x, y);
        } else {
          image(board.ibpawn, x, y);
        }
        break;
      case 1:
        if (white) {
          image(board.wking, x, y);
        } else {
          image(board.ibking, x, y);
        }
        break;
      case 2:
        if (white) {
          image(board.wqueen, x, y);
        } else {
          image(board.ibqueen, x, y);
        }
        break;
      case 3:
        if (white) {
          image(board.wbishop, x, y);
        } else {
          image(board.ibbishop, x, y);
        }
        break;
      case 4:
        if (white) {
          image(board.wknight, x, y);
        } else {
          image(board.ibknight, x, y);
        }
        break;
      case 5:
        if (white) {
          image(board.wtower, x, y);
        } else {
          image(board.ibtower, x, y);
        }
        break;
      }
    } else {
      switch(type) {
      case 0:
        if (white) {
          image(board.wpawn, x, y);
        } else {
          image(board.bpawn, x, y);
        }
        break;
      case 1:
        if (white) {
          image(board.wking, x, y);
        } else {
          image(board.bking, x, y);
        }
        break;
      case 2:
        if (white) {
          image(board.wqueen, x, y);
        } else {
          image(board.bqueen, x, y);
        }
        break;
      case 3:
        if (white) {
          image(board.wbishop, x, y);
        } else {
          image(board.bbishop, x, y);
        }
        break;
      case 4:
        if (white) {
          image(board.wknight, x, y);
        } else {
          image(board.bknight, x, y);
        }
        break;
      case 5:
        if (white) {
          image(board.wtower, x, y);
        } else {
          image(board.btower, x, y);
        }
        break;
      }
    }
  }
}

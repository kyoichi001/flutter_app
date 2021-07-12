

class CanvasLayer{
  int sizeX;
  int sizeY;
  List<int> ids = [];

  void init(int sizeX,int sizeY,List<int> data) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    if (data.length != sizeX * sizeY) {//不正な初期値なので何もないセルに
      for (int i = 0; i < sizeY * sizeX; i++) {
        ids.add(0);
      }
    } else {
      for (int i = 0; i < sizeY * sizeX; i++) {
        ids.add(data[i]);
      }
    }
  }

  void setID(int x, int y, int id) {
    ids[y * sizeX + x] = id;
  }
  void setID2(int target, int id) {
    ids[target] = id;
  }
  int getID(int x, int y) {
    return ids[y * sizeX + x];
  }
  int getID2(int target) {
    return ids[target];
  }

  void reverseX() {
    for (int y = 0; y < sizeY; y++) {
      for (int x = 0; x < sizeX / 2; x++) {
        int tmp = getID(x, y);
        setID(x, y, getID(sizeX - x - 1, y));
        setID(sizeX - x - 1, y, tmp);
      }
    }
  }

  void reverseY() {
    for (int y = 0; y < sizeY / 2; y++) {
      for (int x = 0; x < sizeX; x++) {
        int tmp = getID(x, y);
        setID(x, y, getID(x, sizeY - y - 1));
        setID(x, sizeY - y - 1, tmp);
      }
    }
  }

  void swapXY() {
    for (int y = 1; y < sizeY; y++) {
      for (int x = 0; x < y; x++) {
        int tmp = getID(x, y);
        setID(x, y, getID(y, x));
        setID(y, x, tmp);
      }
    }
  }

  //https://daeudaeu.com/2d-rotate/
  void rotateLeft() {
    swapXY();
    reverseX();
  }

  //正方形だからできる。xとyの数が違う場合、また別の処理
  void rotateRight() {
    List<int> ids2 = [];
    for(int i=0;i<sizeY*sizeX;i++)ids2.add(0);
    for(int x = 0; x < sizeX; x++){
      for(int y = 0; y < sizeY; y++){
        ids2[y*sizeX+x]=getID(sizeY-1-x,y);
      }
    }
    for(int i=0;i<sizeY*sizeX;i++)ids[i]=ids2[i];
  }
}


class Cell{
  int x;
  int y;
  Cell(this.x,this.y);
}

class DotCanvas {
  int sizeX;
  int sizeY;
  CanvasLayer normal = CanvasLayer();
  CanvasLayer preview = CanvasLayer();
  bool isEditing = false;

  void init(int sizeX,int sizeY,List<int> data) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    normal.init(sizeX, sizeY, data);
    preview.init(sizeX, sizeY, data);
  }

  void setID(int x, int y, int id) {
    if (x < 0 || y < 0 || x >= sizeX || y >= sizeY) return;
    preview.setID(x, y, id);
    isEditing = true;
  }

  void apply() {
    isEditing = false;
    for (int y = 0; y < sizeY; y++) {
      for (int x = 0; x < sizeX; x++) {
        normal.setID(x, y, preview.getID(x, y));
      }
    }
  }

  void cancel() {
    isEditing = false;
    for (int y = 0; y < sizeY; y++) {
      for (int x = 0; x < sizeX; x++) {
        preview.setID(x, y, normal.getID(x, y));
      }
    }
  }

  void clear() {
    for (int y = 0; y < sizeY; y++) {
      for (int x = 0; x < sizeX; x++) {
        setID(x, y, 0);
      }
    }
    apply();
  }

  int getID(int x, int y) {
    return normal.getID(x, y);
  }

  int getPreviewID(int x, int y) {
    return preview.getID(x, y);
  }

  void reverseX() {
    normal.reverseX();
    preview.reverseX();
  }

  void reverseY() {
    normal.reverseY();
    preview.reverseY();
  }

  void rotateLeft() {
    normal.rotateLeft();
    preview.rotateLeft();
  }

  void rotateRight() {
    normal.rotateRight();
    preview.rotateRight();
  }
}

class CanvasLayer{
  int sizeX;
  int sizeY;
  List<int> ids = [];

  void init(int sizeX,int sizeY,List<int> data) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    if (data.length == 0) {
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
    if (x < 0 || y < 0 || x >= sizeX || y >= sizeY) return;
    ids[y * sizeX + x] = id;
  }
  int getID(int x, int y) {
    if (x < 0 || y < 0 || x >= sizeX || y >= sizeY) return 0;
    return ids[y * sizeX + x];
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
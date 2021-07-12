

import 'canvasLayer.dart';

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
  CanvasLayer selection = CanvasLayer();
  CanvasLayer selectionPreview = CanvasLayer();
  bool isEditing = false;

  void init(int sizeX,int sizeY,List<int> data) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    normal.init(sizeX, sizeY, data);
    preview.init(sizeX, sizeY, data);
    selection.init(sizeX,sizeY,[]);
    selectionPreview.init(sizeX,sizeY,[]);
  }

  void setID(int x, int y, int id) {
    if (x < 0 || y < 0 || x >= sizeX || y >= sizeY) return;
    preview.setID(x, y, id);
    isEditing = true;
  }
  void setID2(int target, int id) {
    if (target < 0 ||target >= sizeY*sizeX) return;
    preview.setID2(target, id);
    isEditing = true;
  }
  void setSelection(int x, int y, bool selects) {
    if (x < 0 || y < 0 || x >= sizeX || y >= sizeY) return;
    selectionPreview.setID(x, y, 1);
    isEditing = true;
  }

  void apply() {
    isEditing = false;
    for (int y = 0; y < sizeY; y++) {
      for (int x = 0; x < sizeX; x++) {
        normal.setID(x, y, preview.getID(x, y));
        selection.setID(x, y, selectionPreview.getID(x, y));
      }
    }
  }

  void cancel() {
    isEditing = false;
    for (int y = 0; y < sizeY; y++) {
      for (int x = 0; x < sizeX; x++) {
        preview.setID(x, y, normal.getID(x, y));
        selection.setID(x, y, selectionPreview.getID(x, y));
      }
    }
  }

  void clear() {
    for (int y = 0; y < sizeY; y++) {
      for (int x = 0; x < sizeX; x++) {
        preview.setID(x, y, 0);
        normal.setID(x, y, 0);
        selection.setID(x, y,0);
        selectionPreview.setID(x, y,0);
      }
    }
  }

  int getID(int x, int y) {
    return normal.getID(x, y);
  }
  int getID2(int target) {
    return normal.getID2(target);
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
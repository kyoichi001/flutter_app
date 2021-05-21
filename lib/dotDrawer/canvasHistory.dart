import 'dart:collection';
import 'dotcanvas.dart';

class CanvasHistory {
  int sizeX;
  int sizeY;

  int currentIndex = 0;

  List<List<int>> stack = [[]];

  CanvasHistory(this.sizeX, this.sizeY);

  void add(List<int> data) {
    List<int> clone = [];
    for (int i = 0; i < data.length; i++) {//引数をコピー
      clone.add(data[i]);
    }

    for (int i = currentIndex; i < stack.length - 1; i++) { //redoを消去
      stack.removeLast();
    }
    stack.add(clone);
    currentIndex = stack.length - 1;
  }

  List<int> pop() {
    currentIndex--;
    return stack[currentIndex];
  }

  List<int> back() {
    currentIndex++;
    return stack[currentIndex];
  }

  //最初の要素はキャンバスの初期値（削除されると最初の状態が上書きされてしまう）
  bool canUndo() {
    return currentIndex > 1;
  }

  bool canRedo() {
    return currentIndex < stack.length-1;
  }

}
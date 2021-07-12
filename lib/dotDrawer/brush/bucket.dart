import 'dart:collection';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';


class BucketBrush extends BaseBrush {


  BucketBrush(DotCanvas canvas, ColorPalette palette) : super(canvas, palette);

  @override
  void onPressEnter(int x, int y) {
    List<bool> viewed = new List.filled(canvas.sizeX * canvas.sizeY, false);
    Queue<int> queue = Queue<int>();
    queue.add(y * canvas.sizeX + x);
    viewed[y * canvas.sizeX + x] = true;
    var targetID = canvas.getID2(y * canvas.sizeX + x);
    while (queue.isNotEmpty) {
      var target = queue.removeFirst();
      canvas.setID2(target, palette.currentColor);
      int X = target % canvas.sizeX;
      int Y = target ~/ canvas.sizeX;
      if (isValid(X + 1, Y) && !viewed[target + 1] &&
          canvas.getID(X + 1, Y) == targetID) {
        queue.add(target + 1);
        viewed[target + 1] = true;
      }
      if (isValid(X - 1, Y) && !viewed[target - 1] &&
          canvas.getID(X - 1, Y) == targetID) {
        queue.add(target - 1);
        viewed[target - 1] = true;
      }
      if (isValid(X, Y + 1) && !viewed[target + canvas.sizeX] &&
          canvas.getID(X, Y + 1) == targetID) {
        queue.add(target + canvas.sizeX);
        viewed[target + canvas.sizeX] = true;
      }
      if (isValid(X, Y - 1) && !viewed[target - canvas.sizeX] &&
          canvas.getID(X, Y - 1) == targetID) {
        queue.add(target - canvas.sizeX);
        viewed[target - canvas.sizeX] = true;
      }
    }
    canvas.apply();
  }

  bool isValid(int x, int y) {
    return x >= 0 && y >= 0 && x < canvas.sizeX && y < canvas.sizeY;
  }

  @override
  void onPress(int x, int y) {}

  @override
  void onPressExit(int x, int y) {}

}
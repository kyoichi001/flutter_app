import 'dart:math';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

//キャンバス全体をドラッグで動かす
class MoveBrush extends BaseBrush{

  MoveBrush(DotCanvas canvas,ColorPalette palette) : super(canvas,palette);
  Cell start;

  @override
  void onPress(int x_, int y_) {
    Cell delta=Cell(x_-start.x,y_-start.y);
    canvas.cancel();
    for (int y = 0; y <=canvas.sizeY; y++) {
      for (int x = 0; x <= canvas.sizeX; x++) {
        canvas.setID(x, y, canvas.getID(x-delta.x,y -delta.y));
      }
    }

  }

  @override
  void onPressEnter(int x, int y) {
    //print("rect start");
    start=Cell(x,y);
  }

  @override
  void onPressExit(int x_, int y_) {
    canvas.apply();
  }

}
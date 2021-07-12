import 'dart:math';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';


class RectBrush extends BaseBrush{

  RectBrush(DotCanvas canvas,ColorPalette palette) : super(canvas,palette);
  Cell start;

  @override
  void onPress(int x_, int y_) {
    canvas.cancel();
    var end = Cell(x_, y_);
    var lb = Cell(min(start.x, end.x), min(start.y, end.y));
    var rt = Cell(max(start.x, end.x), max(start.y, end.y));

    for (int y = lb.y; y <= rt.y; y++) {
      for (int x = lb.x; x <= rt.x; x++) {
        canvas.setID(x, y, palette.currentColor);
      }
    }
  }

  @override
  void onPressEnter(int x, int y) {
    print("rect start");
    start=Cell(x,y);
  }

  @override
  void onPressExit(int x_, int y_) {
    print("rect end");
    canvas.apply();
  }

}
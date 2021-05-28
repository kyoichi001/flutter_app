import 'dart:math';
import 'dart:ui';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';

//https://en.wikipedia.org/wiki/Midpoint_circle_algorithm

class CircleBrush extends BaseBrush {

  CircleBrush(DotCanvas canvas, ColorPalette palette) : super(canvas, palette);
  Cell start;

  @override
  void onPress(int x_, int y_) {
    canvas.cancel();
    var end = Cell(x_, y_);
    var lb = Cell(min(start.x, end.x), min(start.y, end.y));
    var rt = Cell(max(start.x, end.x)+1, max(start.y, end.y)+1);

    var center = Offset((lb.x + rt.x) / 2, (lb.y + rt.y) / 2);
    double r = rt.x - center.dx;
    int y0 = center.dy.floor();
    int x = rt.x;
    for(int y=y0;y<=x;y++){
      canvas.setID(x,y, palette.currentColor);
      canvas.setID(x,-y, palette.currentColor);
      canvas.setID(-x,y, palette.currentColor);
      canvas.setID(-x,-y, palette.currentColor);
      canvas.setID(y,x, palette.currentColor);
      canvas.setID(y,-x, palette.currentColor);
      canvas.setID(-y,x, palette.currentColor);
      canvas.setID(-y,-x, palette.currentColor);
      if (RE(x - 1, y + 1, r) < RE(x, y + 1, r)) {
        x-=1;
      }
    }
  }

  @override
  void onPressEnter(int x, int y) {
    start = Cell(x, y);
  }

  @override
  void onPressExit(int x_, int y_) {
    canvas.apply();
  }


  double RE(int x,int y, double r) {
    return (x * x + y * y - r * r).abs();
  }

}
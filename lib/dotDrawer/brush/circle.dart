import 'dart:math';
import 'dart:ui';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';


class CircleBrush extends BaseBrush {

  CircleBrush(DotCanvas canvas, ColorPalette palette) : super(canvas, palette);
  Cell start;

  @override
  void onPress(int x_, int y_) {
    canvas.cancel();
    var end = Cell(x_, y_);
    var lb = Cell(min(start.x, end.x), min(start.y, end.y));
    var rt = Cell(max(start.x, end.x), max(start.y, end.y));

    var center = Offset((lb.x + rt.x) / 2, (lb.y + rt.y) / 2);
    var radiusX = ((rt.x - lb.x) / 2).abs();
    var radiusY = ((rt.y - lb.y) / 2).abs();

    for (int y = lb.y; y <= rt.y; y++) {
      for (int x = lb.x; x <= rt.x; x++) {
        if (isInside(x, y, center, radiusX,radiusY))
          canvas.setID(x, y, palette.currentColor);
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

  bool isInside(int x, int y, Offset center, double xr,double yr) {
    double dx = x - center.dx;
    double dy = y - center.dy;
    return dx * dx*yr*yr + dy * dy*xr*xr <= xr*xr*yr*yr+0.5;
  }

}
import 'dart:math';
import 'dart:ui';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

//https://en.wikipedia.org/wiki/Midpoint_circle_algorithm

class CircleBrush extends BaseBrush {

  CircleBrush(DotCanvas canvas, ColorPalette palette) : super(canvas, palette);
  Cell start;

  @override
  void onPress(int x_, int y_) {
    canvas.cancel();
    var end = Cell(x_, y_);
    var lb = Cell(min(start.x, end.x), min(start.y, end.y));
    var rt = Cell(max(start.x, end.x) + 1, max(start.y, end.y) + 1);

    if (lb.x == rt.x) {
      for (int y = lb.y; y <= rt.y; y++) {
        canvas.setID(lb.x, y, palette.currentColor);
      }
      return;
    }

    if (lb.y == rt.y) {
      for (int x = lb.x; x <= rt.x; x++) {
        canvas.setID(x, lb.y, palette.currentColor);
      }
      return;
    }

    var center = Offset((lb.x + rt.x) / 2, (lb.y + rt.y) / 2);
    double xr = (rt.x - center.dx).abs();
    double yr = (rt.y - center.dy).abs();
    int y0 = 0;
    int x = xr.floor();
    int xCenter = center.dx.floor();
    int yCenter = center.dy.floor();
    for (int y = y0; y <= x; y++) {
      canvas.setID(x + xCenter, y + yCenter, palette.currentColor);
      canvas.setID(x + xCenter, -y + yCenter, palette.currentColor);
      canvas.setID(-x + xCenter, y + yCenter, palette.currentColor);
      canvas.setID(-x + xCenter, -y + yCenter, palette.currentColor);
      if (RE(x - 1, y + 1, xr, yr) < RE(x, y + 1, xr, yr)) {
        x -= 1;
      }
    }
    int y = yr.floor();
    int x0 = 0;
    for (int x = x0; x <= y; x++) {
      canvas.setID(x + xCenter, y + yCenter, palette.currentColor);
      canvas.setID(x + xCenter, -y + yCenter, palette.currentColor);
      canvas.setID(-x + xCenter, y + yCenter, palette.currentColor);
      canvas.setID(-x + xCenter, -y + yCenter, palette.currentColor);
      if (RE(x + 1, y - 1, xr, yr) < RE(x + 1, y, xr, yr)) {
        y -= 1;
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


  double RE(int x, int y, double xr,double yr) {
    return (
        x * x * yr * yr +
        y * y * xr * xr -
        xr * xr * yr * yr).abs();
  }

}
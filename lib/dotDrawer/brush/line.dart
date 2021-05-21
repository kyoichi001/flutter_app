import 'dart:math';
import 'dart:ui';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';


class LineBrush extends BaseBrush{

  LineBrush(DotCanvas canvas,ColorPalette palette) : super(canvas,palette);
  Cell start;

  @override
  void onPress(int x_, int y_) {
    canvas.cancel();
    var end = Cell(x_, y_);
    var yBegin = min(start.y, end.y);
    var xBegin = min(start.x, end.x);
    var yEnd = max(start.y, end.y);
    var xEnd = max(start.x, end.x);
    var dy = yEnd - yBegin;
    var dx = xEnd - xBegin;
    if(dx==0) {
      for (int t = yBegin; t <= yEnd; t++) {
        canvas.setID(xBegin, t, palette.currentColor);
      }
    }else{
      if(dx>dy){
        for (int t = xBegin; t <= xEnd; t++) {
          int f = yBegin + (dy * (t - xBegin) / dx).floor();
          canvas.setID(t, f, palette.currentColor);
        }
      }else{
        for (int t = yBegin; t <= yEnd; t++) {
          int f = xBegin + (dx * (t - yBegin) / dy).floor();
          canvas.setID(f, t, palette.currentColor);
        }
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
import 'dart:math';
import 'dart:ui';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';


class LineBrush extends BaseBrush {

  LineBrush(DotCanvas canvas, ColorPalette palette) : super(canvas, palette);
  Cell start;

  @override
  void onPress(int x_, int y_) {
    canvas.cancel();
    var end = Cell(x_, y_);
    if (end.x == start.x) {
      if (end.y >= start.y) {
        for (int y = start.y; y <= end.y; y++) {
          canvas.setID(start.x, y, palette.currentColor);
        }
      } else {
        for (int y = end.y; y <= start.y; y++) {
          canvas.setID(start.x, y, palette.currentColor);
        }
      }
      return;
    }
    if (end.x >= start.x && end.y >= start.y) {
      if (end.x - start.x > end.y - start.y) {
        line1X(start.x, start.y, end.x, end.y);
      } else {
        line1Y(start.x, start.y, end.x, end.y);
      }
      return;
    }

    if (end.x <= start.x && end.y >= start.y) {
      if (start.x - end.x > end.y - start.y) {
        line2X(start.x, start.y, end.x, end.y);
      } else {
        line2Y(start.x, start.y, end.x, end.y);
      }
      return;
    }

    if (end.x <= start.x && end.y <= start.y) {
      if (start.x - end.x > start.y - end.y) {
        line3X(start.x, start.y, end.x, end.y);
      } else {
        line3Y(start.x, start.y, end.x, end.y);
      }
      return;
    }

    if (end.x >= start.x && end.y <= start.y) {
      if (end.x - start.x > start.y - end.y) {
        line4X(start.x, start.y, end.x, end.y);
      } else {
        line4Y(start.x, start.y, end.x, end.y);
      }
      return;
    }
  }

  @override
  void onPressEnter(int x, int y) {
    print("rect start");
    start = Cell(x, y);
  }

  @override
  void onPressExit(int x_, int y_) {
    print("rect end");
    canvas.apply();
  }

  //https://ja.wikipedia.org/wiki/%E3%83%96%E3%83%AC%E3%82%BC%E3%83%B3%E3%83%8F%E3%83%A0%E3%81%AE%E3%82%A2%E3%83%AB%E3%82%B4%E3%83%AA%E3%82%BA%E3%83%A0
  //第1象限限定(x1>x0, y1>y0, |x1-x0|>|y1-y0|)
  void line1X(int x0, int y0, int x1, int y1) {
    double error = 0;
    double deltaError = (y1 - y0) / (x1 - x0);
    int y = y0;
    for (int x = x0; x <= x1; x++) {
      canvas.setID(x, y, palette.currentColor);
      error += deltaError;
      if (error >= 0.5) {
        y++;
        error -= 1;
      }
    }
  }

  //第2象限限定(x1<x0, y1>y0, |x1-x0|>|y1-y0|)
  void line2X(int x0, int y0, int x1, int y1) {
    double error = 0;
    double deltaError = -(y1 - y0) / (x1 - x0);
    int y = y0;
    for (int x = x0; x >= x1; x--) {
      canvas.setID(x, y, palette.currentColor);
      error += deltaError;
      if (error >= 0.5) {
        y++;
        error -= 1;
      }
    }
  }

  //第3象限限定(x1<x0, y1<y0, |x1-x0|>|y1-y0|)
  void line3X(int x0, int y0, int x1, int y1) {
    double error = 0;
    double deltaError = (y1 - y0) / (x1 - x0);
    int y = y1;
    for (int x = x1; x <= x0; x++) {
      canvas.setID(x, y, palette.currentColor);
      error += deltaError;
      if (error >= 0.5) {
        y++;
        error -= 1;
      }
    }
  }

  //第4象限限定(x1>x0, y1<y0, |x1-x0|>|y1-y0|)
  void line4X(int x0, int y0, int x1, int y1) {
    double error = 0;
    double deltaError = -(y1 - y0) / (x1 - x0);
    int y = y1;
    for (int x = x1; x >= x0; x--) {
      canvas.setID(x, y, palette.currentColor);
      error += deltaError;
      if (error >= 0.5) {
        y++;
        error -= 1;
      }
    }
  }

  //第1象限限定(x1>x0, y1>y0, |x1-x0|<|y1-y0|)
  void line1Y(int x0, int y0, int x1, int y1) {
    double error = 0;
    double deltaError = (x1 - x0) / (y1 - y0);
    int x = x0;
    for (int y = y0; y <= y1; y++) {
      canvas.setID(x, y, palette.currentColor);
      error += deltaError;
      if (error >= 0.5) {
        x++;
        error -= 1;
      }
    }
  }

  //第2象限限定(x1<x0, y1>y0, |x1-x0|<|y1-y0|)
  void line2Y(int x0, int y0, int x1, int y1) {
    double error = 0;
    double deltaError = -(x1 - x0) / (y1 - y0);
    int x = x1;
    for (int y = y1; y >= y0; y--) {
      canvas.setID(x, y, palette.currentColor);
      error += deltaError;
      if (error >= 0.5) {
        x++;
        error -= 1;
      }
    }
  }

  //第3象限限定(x1<x0, y1<y0, |x1-x0|<|y1-y0|)
  void line3Y(int x0, int y0, int x1, int y1) {
    double error = 0;
    double deltaError = (x1 - x0) / (y1 - y0);
    int x = x1;
    for (int y = y1; y <= y0; y++) {
      canvas.setID(x, y, palette.currentColor);
      error += deltaError;
      if (error >= 0.5) {
        x++;
        error -= 1;
      }
    }
  }

  //第4象限限定(x1>x0, y1<y0, |x1-x0|<|y1-y0|)
  void line4Y(int x0, int y0, int x1, int y1) {
    double error = 0;
    double deltaError = -(x1 - x0) / (y1 - y0);
    int x = x0;
    for (int y = y0; y >= y1; y--) {
      canvas.setID(x, y, palette.currentColor);
      error += deltaError;
      if (error >= 0.5) {
        x++;
        error -= 1;
      }
    }
  }
}


/*
    var yBegin = min(start.y, end.y);
    var xBegin = min(start.x, end.x);
    var yEnd = max(start.y, end.y);
    var xEnd = max(start.x, end.x);
    var dy = yEnd - yBegin;
    var dx = xEnd - xBegin;
    if (dx == 0) {
      for (int t = yBegin; t <= yEnd; t++) {
        canvas.setID(xBegin, t, palette.currentColor);
      }
      return;
    }
    if (dx > dy) {
      for (int t = xBegin; t <= xEnd; t++) {
        int f = yBegin + (dy * (t - xBegin) / dx).floor();
        canvas.setID(t, f, palette.currentColor);
      }
    } else {
      for (int t = yBegin; t <= yEnd; t++) {
        int f = xBegin + (dx * (t - yBegin) / dy).floor();
        canvas.setID(f, t, palette.currentColor);
      }
    }
    */
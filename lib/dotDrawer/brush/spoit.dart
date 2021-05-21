import 'dart:math';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';


class SpoitBrush extends BaseBrush{

  SpoitBrush(DotCanvas canvas,ColorPalette palette) : super(canvas,palette);

  @override
  void onPress(int x_, int y_) {
  }

  @override
  void onPressEnter(int x, int y) {
  }

  @override
  void onPressExit(int x_, int y_) {
    print("rect end");
    palette.currentColor=canvas.getID(x_, y_);
  }

}
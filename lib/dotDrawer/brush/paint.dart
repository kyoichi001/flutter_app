import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

class PaintBrush extends BaseBrush{

  PaintBrush(DotCanvas canvas,ColorPalette palette) : super(canvas,palette);

  @override
  void onPress(int x, int y) {
    canvas.setID(x, y, palette.currentColor);
  }

  @override
  void onPressEnter(int x, int y) {
    canvas.setID(x, y, palette.currentColor);
  }

  @override
  void onPressExit(int x, int y) {
    canvas.setID(x, y, palette.currentColor);
    canvas.apply();
  }

}
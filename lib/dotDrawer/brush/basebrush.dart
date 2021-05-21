import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';


abstract class BaseBrush{
  DotCanvas canvas;
  ColorPalette palette;
  BaseBrush(this.canvas,this.palette);

  void onPressEnter(int x,int y);
  void onPress(int x,int y);
  void onPressExit(int x,int y);
}
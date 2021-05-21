import 'dart:collection';

import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';


class BucketBrush extends BaseBrush{


  BucketBrush(DotCanvas canvas,ColorPalette palette) : super(canvas,palette);
  Queue<Cell> queue=Queue<Cell>();

  @override
  void onPressEnter(int x, int y) {
    List<bool> viewed=new List.filled(canvas.sizeX*canvas.sizeY, false);
    queue.add(Cell(x,y));
    var targetID=canvas.getID(x, y);
    while(queue.isNotEmpty){
      var cell=queue.removeFirst();
      var X=cell.x;
      var Y=cell.y;
      canvas.setID(X, Y, palette.currentColor);
      viewed[canvas.sizeX*Y+X]=true;
      if(isValid(X+1,Y)&&!viewed[canvas.sizeX*Y+X+1]&&canvas.getID(X+1, Y)==targetID)queue.add(Cell(X+1,Y));
      if(isValid(X-1,Y)&&!viewed[canvas.sizeX*Y+X-1]&&canvas.getID(X-1, Y)==targetID)queue.add(Cell(X-1,Y));
      if(isValid(X,Y+1)&&!viewed[canvas.sizeX*(Y+1)+X]&&canvas.getID(X, Y+1)==targetID)queue.add(Cell(X,Y+1));
      if(isValid(X,Y-1)&&!viewed[canvas.sizeX*(Y-1)+X]&&canvas.getID(X, Y-1)==targetID)queue.add(Cell(X,Y-1));
    }
    canvas.apply();
  }

  bool isValid(int x,int y){
    return x>=0&&y>=0&&x<canvas.sizeX&&y<canvas.sizeY;
  }

  @override
  void onPress(int x, int y) {}
  @override
  void onPressExit(int x, int y) {}

}
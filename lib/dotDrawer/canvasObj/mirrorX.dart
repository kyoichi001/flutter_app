

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

class MirrorX{
  DotCanvas canvas;
  ColorPalette palette;

  int originX;
  
  final _linePaint = Paint()..color = Colors.black;

  void onCanvasPressStart(int x,int y){

  }
  void onCanvasPress(int x,int y){

  }
  void onCanvasPressExit(int x,int y){

  }
  void paint(Canvas canvas, Size size){
   // canvas.drawRect(rect, paint)
    canvas.drawLine(Offset(originX/2,0), Offset(originX/2,size.height), _linePaint);
  }
  void rasterize(){

  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

import 'canvasLayer.dart';

class LayerPainter extends CustomPainter{
  final _rectPaint = Paint();
  CanvasLayer layer;
  ColorPalette palette;
  LayerPainter(this.layer,this.palette);

  @override
  void paint(Canvas canvas, Size size) {
    double rectSize = size.width / layer.sizeX;
    for (int y = 0; y < layer.sizeY; y++) {
      for (int x = 0; x < layer.sizeX; x++) {
        int colID = layer.getID(x, y);
        _rectPaint.color = this.palette.cols[colID];
        drawCell(canvas,_rectPaint,x,y,rectSize);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawCell(Canvas canvas,Paint painter,int x,int y,double rectSize){
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset((x*rectSize).toDouble()+rectSize/2,(y*rectSize).toDouble()+rectSize/2),
          width: rectSize,
          height: rectSize,
        ),
        painter
    );
  }

}
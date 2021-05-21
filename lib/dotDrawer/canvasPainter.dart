

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/palette.dart';

import 'dotcanvas.dart';

class CanvasPainter extends CustomPainter{
  final _linePaint = Paint()..color = Colors.black;
  ColorPalette palette;
  DotCanvas dotCanvas;
  LayerPainter normal;
  LayerPainter preview;

  CanvasPainter(this.dotCanvas,this.palette){
     normal=LayerPainter(dotCanvas.normal, palette);
     preview=LayerPainter(dotCanvas.preview, palette);
  }

  @override
  void paint(Canvas canvas, Size size) {
    double rectSize = size.width / dotCanvas.sizeX;
    normal.paint(canvas, size);
    preview.paint(canvas, size);

    for (int i = 0; i <= dotCanvas.sizeX; i++) {
      canvas.drawLine(Offset(i * rectSize.toDouble(), 0),
          Offset(i * rectSize.toDouble(), size.height), _linePaint);
    }
    for (int i = 0; i <= dotCanvas.sizeY; i++) {
      canvas.drawLine(Offset(0, i * rectSize.toDouble()),
          Offset(size.width, i * rectSize.toDouble()), _linePaint);
    }

    final _linePaint2 = Paint()
      ..color = Colors.black;
    _linePaint2.strokeWidth = 2;
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2, size.height),
        _linePaint2);
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2),
        _linePaint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}


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
        if(_rectPaint.color.alpha==0){
          drawTransparentCell(canvas, x, y, rectSize);
        }else{
          drawCell(canvas,_rectPaint,x,y,rectSize);
        }
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

  void drawTransparentCell(Canvas canvas,int x,int y,double rectSize){
    Paint painter=Paint();
    painter.color=Colors.grey;
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset((x*rectSize).toDouble()+rectSize/2,(y*rectSize).toDouble()+rectSize/2),
          width: rectSize,
          height: rectSize,
        ),
        painter
    );
    painter.color=Colors.white;
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset((x*rectSize).toDouble()+rectSize/4*3,(y*rectSize).toDouble()+rectSize/4*3),
          width: rectSize/2,
          height: rectSize/2,
        ),
        painter
    );
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset((x*rectSize).toDouble()+rectSize/4,(y*rectSize).toDouble()+rectSize/4),
          width: rectSize/2,
          height: rectSize/2,
        ),
        painter
    );
  }
}
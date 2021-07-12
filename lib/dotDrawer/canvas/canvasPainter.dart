

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

import 'dotcanvas.dart';
import 'layerPainter.dart';

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
    if(!dotCanvas.isEditing){
      normal.paint(canvas, size);
    }else{
      preview.paint(canvas, size);
    }
    drawGrid(canvas,size);
  }

  void drawGrid(Canvas canvas,Size size){
    double rectSize = size.width / dotCanvas.sizeX;

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



/*
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
  */
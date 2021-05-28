
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';
import 'package:flutter_app/dotDrawer/paletteWidget.dart';

import 'canvasPainter.dart';

class PaletteEditor extends StatelessWidget {
  PaletteEditor({Key key,this.canvas,this.palette}) : super(key: key);
  ColorPalette palette;
  DotCanvas canvas;

  @override
  Widget build(BuildContext context) {
    List<Widget> colorList = [];
    for (int i = 0; i < palette.cols.length; i++) {
      colorList.add(changeColorButton(i));
    }

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: canvas.sizeX / canvas.sizeY,
                child: Container(
                  width: 500,
                  height: 500,
                  margin: const EdgeInsets.all(10.0),
                  child: CustomPaint(
                    painter: CanvasPainter(
                        this.canvas, this.palette
                    ),
                  ),
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: colorList,
              )
            ]
        ),
      ),
    );
  }

  Widget changeColorButton(int id) {
    return IconButton(
        onPressed: () {

        },
        color: palette.cols[id],
        icon: Icon(Icons.circle)
    );
  }
}
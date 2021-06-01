
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';
import 'package:flutter_app/dotDrawer/paletteWidget.dart';

import 'canvasPainter.dart';

class PaletteEditorPage extends StatefulWidget {
  PaletteEditorPage({Key key, this.canvas, this.palette}) : super(key: key);
  final ColorPalette palette;
  final DotCanvas canvas;


  @override
  PaletteEditorPageState createState() => PaletteEditorPageState();
}

class PaletteEditorPageState extends State<PaletteEditorPage> {

  double hue = 0;
  double saturate = 0;
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: widget.canvas.sizeX / widget.canvas.sizeY,
                child: Container(
                  width: 500,
                  height: 500,
                  margin: const EdgeInsets.all(10.0),
                  child: CustomPaint(
                    painter: CanvasPainter(
                        widget.canvas, widget.palette
                    ),
                  ),
                ),
              ),
              PaletteWidget(
                palette: widget.palette,
                onButtonPressed: (int id) {
                  var col = widget.palette.cols[id];
                  var hsv = HSVColor.fromColor(col);
                  setState(() {
                    hue = hsv.hue;
                    saturate = hsv.saturation;
                    value = hsv.value;
                  });
                },
              ),
              Text("色相"),
              Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(child: Text("0")),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbColor: HSVColor.fromAHSV(1, hue, 1, 1)
                                .toColor(),
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 12),
                            overlayColor: HSVColor.fromAHSV(0.8, hue, 1, 1)
                                .toColor(),
                          ),
                          child: Slider(
                            min: 0,
                            max: 360,
                            label: "色相",
                            value: hue,
                            onChanged: (value) {
                              setState(() {
                                hue = value;
                              });
                            },
                          ),

                        ),
                      ),
                      Container(child: Text("360")),
                    ],
                  )
              ),
              Text("彩度"),
              Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(child: Text("0")),
                      Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbColor: HSVColor.fromAHSV(1, hue, saturate, 1)
                                  .toColor(),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12),
                              overlayColor: HSVColor.fromAHSV(0.8, hue, saturate, 1)
                                  .toColor(),
                            ),
                            child: Slider(
                              min: 0,
                              max: 1,
                              value: saturate,
                              onChanged: (value) {
                                setState(() {
                                  saturate = value;
                                });
                              },
                            ),
                          )
                      ),
                      Container(child: Text("100")),
                    ],
                  )
              ),
              Text("明度"),
              Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(child: Text("0")),
                      Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbColor: HSVColor.fromAHSV(1, hue, 0, value)
                                  .toColor(),
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12),
                              overlayColor: HSVColor.fromAHSV(0.8, hue, 0, value)
                                  .toColor(),
                            ),
                            child: Slider(
                              min: 0,
                              max: 1,
                              value: value,
                              onChanged: (value_) {
                                setState(() {
                                  value = value_;
                                });
                              },
                            ),
                          )
                      ),
                      Container(child: Text("100")),
                    ],
                  )
              ),
            ]
        ),
      ),
    );
  }
}
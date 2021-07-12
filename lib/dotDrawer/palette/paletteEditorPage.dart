
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/canvas/canvasPainter.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';
import 'package:flutter_app/dotDrawer/palette/paletteWidget.dart';

import '../../GradientSlider.dart';

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

  final List<Color> hueGradient=[
    HSVColor.fromAHSV(1, 0, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 30, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 60, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 90, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 120, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 150, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 180, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 210, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 240, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 270, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 300, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 330, 1, 1).toColor(),
    HSVColor.fromAHSV(1, 360, 1, 1).toColor(),
  ];

  @override
  Widget build(BuildContext context) {
    var col = widget.palette.cols[widget.palette.currentColor];
    var hsv = HSVColor.fromColor(col);
    hue = hsv.hue;
    saturate = hsv.saturation;
    value = hsv.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('パレット編集'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: widget.canvas.sizeX / widget.canvas.sizeY,
                child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(0.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: CanvasPainter(
                            widget.canvas, widget.palette
                        ),
                      ),
                    )
                ),
              ),
              PaletteWidget(
                palette: widget.palette,
                onButtonPressed: (int id) {
                  widget.palette.currentColor = id;
                  var col = widget.palette.cols[id];
                  var hsv = HSVColor.fromColor(col);
                  setState(() {
                    hue = hsv.hue;
                    saturate = hsv.saturation;
                    value = hsv.value;
                  });
                },
              ),
              HuePicker(
                width: 360,
                gradient:hueGradient,
                value: hue,
                max:360.0,
                onValueChanged: (value_) {
                  setState(() {
                    hue = value_*360.0;
                    widget.palette.cols[widget.palette
                        .currentColor] =
                        HSVColor.fromAHSV(1, hue, saturate, value)
                            .toColor();
                  });
                },
              ),
              HuePicker(
                width: 360,
                gradient: [
                  HSVColor.fromAHSV(1, hue, 0, value).toColor(),
                  HSVColor.fromAHSV(1, hue, 1, value).toColor(),
                ],
                value: saturate,
                max:1.0,
                onValueChanged: (value_) {
                  setState(() {
                    saturate = value_;
                    widget.palette.cols[widget.palette
                        .currentColor] =
                        HSVColor.fromAHSV(1, hue, saturate, value)
                            .toColor();
                  });
                },
              ),
              HuePicker(
                width: 360,
                gradient: [
                  HSVColor.fromAHSV(1, hue, saturate, 0).toColor(),
                  HSVColor.fromAHSV(1, hue, saturate, 1).toColor(),
                ],
                value: value,
                max:1.0,
                onValueChanged: (value_) {
                  setState(() {
                    value = value_;
                    widget.palette.cols[widget.palette
                        .currentColor] =
                        HSVColor.fromAHSV(1, hue, saturate, value)
                            .toColor();
                  });
                },
              ),
            ]
        ),
      ),
    );
  }
}


class PaletteSlider extends StatelessWidget {

  final String label;
  final Color color;
  final double start;
  final double end;
  final double value;
  final Function(double) onValueChanged;

  PaletteSlider(
      {Key key, this.label, this.color, this.start, this.end, this.value, this.onValueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Container(
            margin: EdgeInsets.all(3),
            width: double.infinity,
            child: Row(
              children: [
                //Container(child: Text(start.toString())),
                Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: color,
                        thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 12),
                        overlayColor: color.withAlpha(180),
                      ),
                      child: Slider(
                        min: start,
                        max: end,
                        value: value,
                        onChanged: onValueChanged,
                      ),
                    )
                ),
                //Container(child: Text(end.toString())),
              ],
            )
        ),
      ],
    );
  }
}
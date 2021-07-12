import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//https://medium.com/@mhstoller.it/how-i-made-a-custom-color-picker-slider-using-flutter-and-dart-e2350ec693a1

class _SliderIndicatorPainter extends CustomPainter {
  final double position;
  _SliderIndicatorPainter(this.position);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(position, size.height / 2), 12, Paint()..color = Colors.black);
  }
  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    return true;
  }
}

class HuePicker extends StatelessWidget {
  final double width;
  final double max;
  final List<Color> gradient;
  final double value;
  final Function(double) onValueChanged;

  HuePicker(
      {Key key, this.width, this.max,this.gradient, this.value, this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (DragStartDetails details) {
            _colorChangeHandler(details.localPosition.dx);
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            _colorChangeHandler(details.localPosition.dx);
          },
          onTapDown: (TapDownDetails details) {
            _colorChangeHandler(details.localPosition.dx);
          },
          //This outside padding makes it much easier to grab the   slider because the gesture detector has
          // the extra padding to recognize gestures inside of
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              width: width,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey[800]),
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: gradient),
              ),
              child: CustomPaint(
                painter: _SliderIndicatorPainter(value/max*width),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > width) position = width;
    if (position < 0) position = 0;
    print(position);
    onValueChanged(position / width);
  }

}
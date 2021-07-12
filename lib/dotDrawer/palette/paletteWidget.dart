
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

class PaletteWidget extends StatelessWidget {
  Function(int) onButtonPressed;
  ColorPalette palette;

  PaletteWidget({Key key, this.onButtonPressed, this.palette})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> colorList = [];
    for (int i = 0; i < palette.cols.length; i++) {
      colorList.add(changeColorButton(i));
    }
    //colorList.add(openEditorButton());
    var w = MediaQuery
        .of(context)
        .size
        .width;
    return Container(
        width: w,
        color: Color.fromARGB(255, 57, 52, 52),
        child: Row(
          children: colorList,
        )
    );
  }

  Widget changeColorButton(int id) {
    return
      Expanded(
        child: Container(
            width: 30,
            height: 40,
            decoration: palette.isIndexSelected(id) ? BoxDecoration(
              border: Border.all(color: Color(0xFFFFADC7), width: 4.0),
            ) : null,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "images/transparent.png",
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    primary: palette.cols[id],
                  ),
                  onPressed: () {
                    onButtonPressed(id);
                  },
                ),
              ],
            )
        ),
      );
  }
}
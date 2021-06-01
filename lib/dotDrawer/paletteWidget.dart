
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/palette.dart';

class PaletteWidget extends StatelessWidget {
  Function(int) onButtonPressed;
  ColorPalette palette;

  PaletteWidget(
      {Key key, this.onButtonPressed, this.palette})
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
            child: Stack(
              children: [
                Positioned.fill(
                  child:Image.asset(
                      "images/transparent.png",
                    repeat: ImageRepeat.repeat,
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    onButtonPressed(id);
                  },
                  color: palette.cols[id],
                ),
              ],
            )
        ),
      );
  }

  /*Widget openEditorButton() {
    return Expanded(child: Container(
      width: 30,
      height: 40,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            onEditorOpen();
          },
          child: Icon(
            Icons.edit,
            size: 20,
          )
      ),
    ),
    );
  }*/

}


/*
IconButton(
padding: EdgeInsets.all(0),
iconSize: 20.0,
onPressed: () {
onButtonPressed(id);
},
color: palette.cols[id],
icon: Icon(Icons.circle)
);


    IconButton(
        padding: EdgeInsets.all(0),
        iconSize: 20.0,
        icon: Icon(Icons.edit),
        onPressed: onEditorOpen
    );
*/
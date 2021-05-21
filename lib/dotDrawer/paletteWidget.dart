
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/palette.dart';

class PaletteWidget extends StatefulWidget {
  Function(int) onButtonPressed;
  Function onEditorOpen;
  ColorPalette palette;
  PaletteWidget({Key key,this.onButtonPressed,this.onEditorOpen,this.palette}) : super(key: key);

  @override
  _SelectColorState createState() => _SelectColorState();

}

class _SelectColorState extends State<PaletteWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> colorList=[];
    for(int i=0;i<widget.palette.cols.length;i++){
      colorList.add(changeColorButton(i));
    }
    colorList.add(openEditorButton());

    return Wrap(
      direction: Axis.horizontal,
      children: colorList,
    );
  }

  Widget changeColorButton(int id) {
    return IconButton(
        onPressed: () {
          widget.onButtonPressed(id);
        },
        color: widget.palette.cols[id],
        icon: Icon(Icons.circle)
    );
  }

  Widget openEditorButton(){
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: widget.onEditorOpen
    );

  }

}
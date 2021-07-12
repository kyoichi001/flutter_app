
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final bool isSelected;
  ToolButton({Key key, this.onPressed, this.icon,this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        decoration: isSelected ? BoxDecoration(
          border: Border.all(color: Color(0xFFFFADC7),width: 4.0),
        ) : null,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Icon(icon),
          ),
        )
    );
  }
}

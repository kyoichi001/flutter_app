
import 'package:flutter/material.dart';

class ColorPalette{
  int currentColor=1;

  List<Color> cols=[];
  static const List<Color> defaultCols=[
    Color.fromARGB(0, 0, 0, 0),//透明色
    Colors.white,
    Colors.grey,
    Colors.black,
    Colors.red,

    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,

    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Color.fromARGB(255, 255, 217, 249),

    Colors.pink,
    Colors.brown,
  ];

  ColorPalette();
  void init(List<int> values){
    cols=[];
    if(values.length==0){
     for(int i=0;i<defaultCols.length;i++){
       cols.add(defaultCols[i]);
     }
    }else {
      for (int i = 0; i < values.length; i++) {
        cols.add(Color(values[i]));
      }
    }
  }

  List<int> convert(){
    List<int> res=[];
    for(int i=0;i<cols.length;i++){
      res.add(cols[i].value);
    }
    return res;
  }

}
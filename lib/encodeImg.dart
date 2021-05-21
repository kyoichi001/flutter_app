import 'dart:io';
import 'package:flutter_app/dotDrawer/palette.dart';
import 'package:image/image.dart' as ImgLib;

import 'dotDrawer/dotcanvas.dart';
//https://github.com/brendan-duncan/image/wiki/Examples



//path ex) test.png
void encodePNG(String path,int sizeX,int sizeY,List<int> canvas,List<int> palette, int encodeSizeX,int encodeSizeY) {
  print("png encoding"+path);
  ImgLib.Image image = ImgLib.Image(encodeSizeX, encodeSizeY);
  for (int y = 0; y < sizeY; y++) {
    for (int x = 0; x < sizeX; x++) {
      image.setPixel(x, y, palette[canvas[y * sizeX + x]]);
    }
  }
  var file=File(path);
  file.writeAsBytesSync(ImgLib.encodePng(image));
}

void encodePNGBase64(String path,DotCanvas canvas,ColorPalette palette, int encodeSizeX,int encodeSizeY){
  ImgLib.Image image = ImgLib.Image(encodeSizeX, encodeSizeY);
  for(int y=0;y<canvas.sizeY;y++) {
    for (int x = 0; x < canvas.sizeX; x++) {
      image.setPixel(x, y, palette.cols[canvas.getID(x, y)].value);
    }
  }
  File(path).writeAsBytesSync(ImgLib.encodePng(image));
}

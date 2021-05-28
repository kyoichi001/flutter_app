import 'dart:io';
import 'package:image/image.dart' as ImgLib;

//https://github.com/brendan-duncan/image/wiki/Examples



//path ex) test.png
void encodePNG(String path,int sizeX,int sizeY,List<int> canvas,List<int> palette, int encodeSizeX,int encodeSizeY) {
  print("png encoding" + path);
  ImgLib.Image image = ImgLib.Image(encodeSizeX, encodeSizeY);
  for (int y = 0; y < encodeSizeY; y++) {
    for (int x = 0; x < encodeSizeX; x++) {
      var canvasX = (x * sizeX / encodeSizeX).floor();
      var canvasY = (y * sizeY / encodeSizeY).floor();

      var red = (palette[canvas[canvasY * sizeX + canvasX]] & 0x00FF0000) >> 16;
      var green = (palette[canvas[canvasY * sizeX + canvasX]] & 0x0000FF00) >> 8;
      var blue = (palette[canvas[canvasY * sizeX + canvasX]] & 0x000000FF);
      //print("$red , $green , $blue");
      image.setPixel(x, y, ImgLib.getColor(red, green, blue));
    }
  }
  var file = File(path);
  file.writeAsBytesSync(ImgLib.encodePng(image));
}

void encodePNGBase64(String path,int sizeX,int sizeY,List<int> canvas,List<int> palette, int encodeSizeX,int encodeSizeY){
  ImgLib.Image image = ImgLib.Image(encodeSizeX, encodeSizeY);
  for(int y=0;y<encodeSizeY;y++) {
    for (int x = 0; x < encodeSizeX; x++) {
      var canvasX=(x*sizeX/encodeSizeX).floor();
      var canvasY=(y*sizeY/encodeSizeY).floor();
      image.setPixel(x, y, palette[canvas[canvasY * sizeX + canvasX]]);
    }
  }
  File(path).writeAsBytesSync(ImgLib.encodePng(image));
}


import 'package:flutter/material.dart';
import 'package:flutter_app/filesave.dart';
import 'dotcanvas.dart';
import 'mainEditor.dart';
import 'palette.dart';

class EditorPage extends StatelessWidget with WidgetsBindingObserver {
  DotCanvas dotCanvas = DotCanvas();
  ColorPalette palette = ColorPalette();
  FileSave saver = FileSave();
  String fileName;

  EditorPage({Key key, this.fileName, int sizeX, int sizeY,
    @required List<int> canvasData, @required List<int> colorPalette})
      : super(key: key) {
    dotCanvas.init(sizeX, sizeY, canvasData);
    palette.init(colorPalette);
  }

  @override
  Widget build(BuildContext context) {
    return MainEditorWidget(
      dotCanvas: dotCanvas,
      palette: palette,
      onSave: save,
    );
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      "format": "0.0.1",
      "sizeX": dotCanvas.sizeX,
      "sizeY": dotCanvas.sizeY,
      "canvas": dotCanvas.normal.ids,
      "palette":palette.convert(),
    };
  }

  void save() {
    saver.save(toJSON(), fileName);
  }

  void export(){

  }

  @override
  void initState() {
    //super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  AppLifecycleState _state;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    if(state==AppLifecycleState.paused){

    }
  }
}


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/filesave.dart';
import 'package:path_provider/path_provider.dart';
import '../encodeImg.dart';
import 'dotcanvas.dart';
import 'mainEditor.dart';
import 'palette.dart';

class EditorPage extends StatelessWidget with WidgetsBindingObserver {
  DotCanvas dotCanvas = DotCanvas();
  ColorPalette palette = ColorPalette();
  String fileName;
  ScaffoldMessengerState messenger;

  EditorPage({Key key, this.fileName, int sizeX, int sizeY,
    @required List<int> canvasData, @required List<int> colorPalette})
      : super(key: key) {
    dotCanvas.init(sizeX, sizeY, canvasData);
    palette.init(colorPalette);
  }

  @override
  Widget build(BuildContext context) {
    messenger=ScaffoldMessenger.of(context);
    return MainEditorWidget(
      dotCanvas: dotCanvas,
      palette: palette,
      onSave: save,
      onExport: export,
    );
  }

  Future<void> save() async {
    SaveFileInfo saveData=SaveFileInfo();
    saveData.filename=fileName;
    saveData.sizeX=dotCanvas.sizeX;
    saveData.sizeY=dotCanvas.sizeY;
    saveData.canvasData=dotCanvas.normal.ids;
    saveData.palleteData=palette.convert();

    try{
      await FileSave.save(saveData, fileName);
      messenger.showSnackBar(
        SnackBar(
          content: Text('file saved\n name:'+fileName),
        ),
      );
    }catch(e){
      messenger.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      print(e);
    }
  }

  void export(){
    //ちゃんとディレクトリ指定しないと許可がないのでエラー
    getTemporaryDirectory().then((directory) {
      encodePNG(
          fileName,
          dotCanvas.sizeX,
          dotCanvas.sizeY,
          dotCanvas.normal.ids,
          palette.convert(),
          dotCanvas.sizeX,
          dotCanvas.sizeX
      );
      messenger.showSnackBar(
        SnackBar(
          content: const Text('png exported'),
        ),
      );
    }).catchError(( e){
      messenger.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      print(e);
    });
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

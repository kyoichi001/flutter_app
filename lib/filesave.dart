import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'encodeImg.dart';


class SaveFileInfo {
  String filename;
  String thumbnailPath;
  int sizeX;
  int sizeY;
  List<int> canvasData;
  List<int> palleteData;
  DateTime createdAt;

  File loadPreview() {
    print("load preview : "+thumbnailPath);
    var file = File(thumbnailPath);
    if (!file.existsSync()) {
      print("file not exist. Create new thumbnail");
      encodePNG(
          thumbnailPath,
          sizeX,
          sizeY,
          canvasData,
          palleteData,
          128,
          128);
    }
    return file;
  }

  void fromJSON(Map<String, dynamic> json) {
    filename=json["filename"];
    sizeX = json["sizeX"];
    sizeY = json["sizeY"];
    palleteData = json["palette"].cast<int>() as List<int>;
    canvasData = json["canvas"].cast<int>() as List<int>;
  }

}

class FileSave{

  static Future<String> getNewFileName()async {
    final directory = await getTemporaryDirectory();
    var files = directory.listSync();
    return "file"+files.length.toString()+".json";
  }

  //作品のリストを取得
  static Future<List<SaveFileInfo>> loadFiles()async {
    try {
      List<SaveFileInfo> ans = [];
      final directory = await getTemporaryDirectory();
      var files = directory.listSync();
      for (int i = 0; i < files.length; i++) {
        if (!files[i].path.endsWith(".json")) continue; //jsonファイルじゃなかったら飛ばす
        final file = File(files[i].path);
        var info = SaveFileInfo();
        String contents = await file.readAsString();
        info.fromJSON(jsonDecode(contents));
        info.filename = basename(files[i].path);
        info.thumbnailPath = setExtension(files[i].path, ".png");
        ans.add(info);
      }
      return ans;
    } catch (e) {
      // If encountering an error, return 0
      print(e);
      return [];
    }
  }

  static Future<void> save(SaveFileInfo info,String filename) async{
    final directory = await getTemporaryDirectory();
    info.thumbnailPath =directory.path + '/'+ setExtension(filename, ".png");
    Map<String,dynamic> json=<String, dynamic>{
      "filename":filename,
      "format": "0.0.1",
      "sizeX": info.sizeX,
      "sizeY": info.sizeY,
      "canvas": info.canvasData,
      "palette": info.palleteData,
      "thumbnailPath":info.thumbnailPath,
    };
    var jsonText = jsonEncode(json);
    print("save file : "+filename);
    encodePNG(
        info.thumbnailPath,
        info.sizeX,
        info.sizeY,
        info.canvasData,
        info.palleteData,
        128,
        128);
    File(directory.path + '/' + filename).writeAsString(jsonText);
  }

  static Future<void> clearData() async{
    final directory = await getTemporaryDirectory();
   var  files = directory.listSync();
    for (int i = 0; i < files.length; i++) {
      await files[i].delete();
      print("deleted: "+files[i].path);
    }

  }

  static Future<void> duplicate(SaveFileInfo info)async{
    SaveFileInfo infos=SaveFileInfo();
    infos.filename=info.filename.split('.')[0]+"_copy.json";
    infos.palleteData=info.palleteData;
    infos.canvasData=info.canvasData;
    infos.createdAt=info.createdAt;
    infos.sizeX=info.sizeX;
    infos.sizeY=info.sizeY;
    infos.thumbnailPath=info.thumbnailPath.split('.')[0]+"_copy.png";
    await save( infos,infos.filename);
  }

  static Future<void> delete(String filename) async{
    final directory = await getTemporaryDirectory();
    await File(directory.path + '/' + filename).delete();
    print("deleted: "+filename);
  }

}
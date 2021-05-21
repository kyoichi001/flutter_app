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
    var file = File(thumbnailPath);
    if (!file.existsSync()) {
      encodePNG(
          thumbnailPath,
          sizeX,
          sizeY,
          canvasData,
          palleteData,
          sizeX,
          sizeY);
    }
    return File(thumbnailPath);
  }

  void fromJSON(Map<String, dynamic> json) {
    sizeX = json["sizeX"];
    sizeY = json["sizeY"];
    palleteData = json["palette"].cast<int>() as List<int>;
    canvasData = json["canvas"].cast<int>() as List<int>;
  }

}

class FileSave{

  List<FileSystemEntity> files=[];

  String getNewFileName(){
    return "file"+files.length.toString();
  }

  //作品のリストを取得
  Future<List<SaveFileInfo>> loadFiles()async {
    try {
      List<SaveFileInfo> ans = [];
      final directory = await getTemporaryDirectory();
      files = directory.listSync();
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

  void save(Map<String,dynamic> json,String filename){
    var jsonText = jsonEncode(json);
    print("save file"+filename);
    getFilePath(filename).then((File file) {
      file.writeAsString(jsonText);
    });
  }

//テキストファイルを保存するパスを取得する
  Future<File> getFilePath(String filename) async {
    final directory = await getTemporaryDirectory();
    return File(directory.path + '/' + filename+".json");
  }

  Future<void> clearData() async{
    try {
      final directory = await getTemporaryDirectory();
      files = directory.listSync();
      for (int i = 0; i < files.length; i++) {
        print("delete: "+files[i].path);
        await files[i].delete();
      }
    } catch (e) {
      // If encountering an error, return 0
      print(e);
    }

  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/filesave.dart';
import 'workWIdget.dart';
import 'dotDrawer/editorPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    print("Works rebuilt");
    //実行しないとサムネが適用されない
    imageCache.clear();
    imageCache.clearLiveImages();
    return Scaffold(
      body: FutureBuilder(
          future: FileSave.loadFiles(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SaveFileInfo>> snapshot) {
            List<Widget> list = [];
            // 通信中はスピナーを表示
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return const Center(
                    child: Text("there is no item")
                );
              }
              for (int i = 0; i < snapshot.data.length; i++) {
                list.add(
                    getWorkWidget(snapshot.data[i])
                );
              }
              return GridView.builder(
                  itemCount: list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return list[index];
                  });
              /*return Wrap(
                spacing: 5,
                direction: Axis.horizontal,
                children: list,
              );*/
            } else {
              return const Center(
                  child: Text("there is no item")
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        heroTag: "new item",
        onPressed: newItem,
        tooltip: 'new item',
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget getWorkWidget(SaveFileInfo info) {
    return WorkWidget(
        info: info,
        onSelected: (info) {
          workWidgetSelected(info);
        },
        onOptionSelected: (var option) {
          if (option == WorkOption.export) {

          } else if (option == WorkOption.delete) {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text("確認"),
                  content:const  Text("削除しますか？"),
                  actions: <Widget>[
                    // ボタン領域
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () async {
                        Navigator.pop(context);
                        await FileSave.delete(info.filename);
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('data deleted'),
                            ),
                          );
                        });
                      },
                    ),
                  ],
                );
              },
            );
          } else if (option == WorkOption.rename) {

          }
        }
    );
  }

  Future<void> newItem() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('create new canvas'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  getButton(16, 16),
                  getButton(32, 32),
                  getButton(64, 64),
                ],
              ),
            ),
          );
        }
    );
  }
//https://qiita.com/sjiro/items/d2bbceac0c27c71f7b2e
  void workWidgetSelected(SaveFileInfo info) async {
    print("page changing");
    final result=await Navigator.push(
        context,
        MaterialPageRoute<bool>(
          builder: (context) =>
              EditorPage(
                fileName: info.filename,
                sizeX: info.sizeX,
                sizeY: info.sizeY,
                canvasData: info.canvasData,
                colorPalette: info.palleteData,
              ),
        )
    );
    print("page returned");
    if(result){
      setState(() {});
    }
  }

  Widget getButton(int sizeX, int sizeY) {
    return TextButton(
      child: Text(sizeX.toString() + "x" + sizeY.toString()),
      onPressed: () {
        sceneChange(sizeX, sizeY);
      },
    );
  }

  void sceneChange(int sizeX, int sizeY) async {
    print("page changing");
    String filename=await FileSave.getNewFileName();

    Navigator.pop(context); //popupを削除
    final result=await Navigator.push(
        context,
        MaterialPageRoute<bool>(
            builder: (context) {
              return EditorPage(
                fileName: filename,
                sizeX: sizeX,
                sizeY: sizeY,
                canvasData: [],
                colorPalette: [],
              );
            }
        )
    );
    print("page returned");
    if(result){
      setState(() {});
    }
  }

}

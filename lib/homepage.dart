
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
    return Scaffold(
      body: FutureBuilder(
          future: FileSave.loadFiles(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SaveFileInfo>> snapshot) {
            List<Widget> list = [];
            // 通信中はスピナーを表示
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data.length; i++) {
                list.add(
                  WorkWidget(
                    info: snapshot.data[i],
                    onSelected: workWidgetSelected,
                    onOptionSelected: (var option) {
                      if (option == WorkOption.export) {

                      } else if (option == WorkOption.delete) {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("確認"),
                              content: Text("削除しますか？"),
                              actions: <Widget>[
                                // ボタン領域
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    FileSave.delete(snapshot.data[i].filename)
                                        .then((void e) {
                                      setState(() {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text('data deleted'),
                                          ),
                                        );
                                      });
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (option == WorkOption.rename) {

                      }
                    },
                  ),
                );
              }
              return Wrap(
                spacing: 5,
                direction: Axis.horizontal,
                children: list,
              );
            } else {
              return Text("there is no item");
            }
          }),
      floatingActionButton: FloatingActionButton(
        heroTag: "new item",
        onPressed: newItem,
        tooltip: 'new item',
        child: Icon(Icons.add),
      ),
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

  void workWidgetSelected(SaveFileInfo info) {
    Navigator.push(
        context,
        MaterialPageRoute(
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
  }

  Widget getButton(int sizeX, int sizeY) {
    return TextButton(
      child: Text(sizeX.toString() + "x" + sizeY.toString()),
      onPressed: () {
        sceneChange(sizeX, sizeY);
      },
    );
  }

  void sceneChange(int sizeX, int sizeY) {
    FileSave.getNewFileName().then((String filename) {
      Navigator.pop(context); //popupを削除
      Navigator.push(
          context,
          MaterialPageRoute(
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
    });
  }

}

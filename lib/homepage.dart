
import 'package:flutter/material.dart';
import 'package:flutter_app/filesave.dart';
import 'workWIdget.dart';
import 'dotDrawer/editorPage.dart';

class HomePage extends StatefulWidget {
  FileSave fileSaver=FileSave();
  HomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Widget> _list=[];
  Future<List<SaveFileInfo>> _future;
  @override
  void initState(){
    _future = asyncSampleMethod();
  }

  Future<List<SaveFileInfo>> asyncSampleMethod() async {
    return await widget.fileSaver.loadFiles();
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
                  getButton(16,16),
                  getButton(32,32),
                  getButton(64,64),
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot<List<SaveFileInfo>> snapshot) {
                Widget childWidget;
                if (snapshot.hasData) {
                  _list.clear();
                  for (int i = 0; i < snapshot.data.length; i++) {
                    _list.add(
                        WorkWidget(info: snapshot.data[i])
                    );
                  }
                  childWidget = GridView.builder(
                    itemCount: _list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                        ),
                        child: _list[index],
                      );
                    },
                  );
                } else {
                  childWidget = const CircularProgressIndicator();
                }
                return childWidget;
              }),
        ),
        floatingActionButton: Column(
          verticalDirection: VerticalDirection.up, // childrenの先頭を下に配置
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: newItem,
              tooltip: 'new item',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: clearData,
              tooltip: 'clear item',
              child: Icon(Icons.delete),
            ),
          ],
        )
    );
  }


  void clearData(){
    widget.fileSaver.clearData().then(
        (void e){
          setState(() {});
        }
    );
  }
  Widget getButton(int sizeX,int sizeY){
    return TextButton(
      child:Text(sizeX.toString()+"x"+sizeY.toString()),
      onPressed: (){
        Navigator.pop(context);//popupを削除
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditorPage(
                fileName: widget.fileSaver.getNewFileName(),
                sizeX: sizeX,
                sizeY: sizeY,
                canvasData: [],
                colorPalette: [],
              ),
            )
        );
      },
    );
  }
}

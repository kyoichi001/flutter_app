
import 'package:flutter/material.dart';
import 'package:flutter_app/theme.dart';

class ToolsID {
  static const int pen = 0;
  static const int bucket = 1;
  static const int rect = 2;
  static const int circle = 3;
  static const int undo = 4;
  static const int redo = 5;

  static const int canvas=2000;
  static const int reverseX=6;
  static const int reverseY=7;
  static const int move=8;
  static const int rotateL=200;
  static const int rotateR=201;

  static const int clear=9;
  static const int spoit=10;
  static const int line=11;
}

class ToolButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;

  ToolButton({Key key, this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Icon(icon),
          ),
        )
    );
  }
}

class ToolsWidget extends StatelessWidget {
  final Function(int) onPressed;
  final  Function(CanvasOption) onCanvasOptionPressed;
  final  Function(FileOption) onFileOptionSelect;
  final  bool undoEnable ;
  final bool redoEnable ;

  ToolsWidget(
      {Key key, this.onPressed, this.onCanvasOptionPressed, this.onFileOptionSelect,this.undoEnable,this.redoEnable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction:Axis.horizontal,
      children: [
        ToolButton(
            onPressed:  () {
              onPressed(ToolsID.pen);
            },
            icon:Icons.brush
        ),
        ToolButton(
            onPressed:  () {
              onPressed(ToolsID.bucket);
            },
            icon:Icons.format_color_fill
        ),
        ToolButton(
            onPressed:  () {
              onPressed(ToolsID.rect);
            },
            icon:Icons.crop_square
        ),
        ToolButton(
            onPressed:  () {
              onPressed(ToolsID.circle);
            },
            icon:Icons.circle
        ),
        ToolButton(
            onPressed:  () {
              onPressed(ToolsID.line);
            },
            icon:Icons.horizontal_rule_outlined
        ),
        ToolButton(
            onPressed:  () {
              onPressed(ToolsID.clear);
            },
            icon:Icons.clear
        ),
        ToolButton(
            onPressed:  () {
              onPressed(ToolsID.spoit);
            },
            icon:Icons.touch_app
        ),
        CanvasOptionWidget(
          onSelect: onCanvasOptionPressed,
        ),
        ToolButton(
            onPressed: !undoEnable ? null : () {
              onPressed(ToolsID.undo);
            },
            icon:Icons.undo
        ),
        ToolButton(
            onPressed: !redoEnable ? null : () {
              onPressed(ToolsID.redo);
            },
            icon:Icons.redo
        ),
        OptionWidget(onSelect: onFileOptionSelect,)
      ],
    );
  }
}


enum CanvasOption{ flipX, flipY, rotateL,rotateR,move}

class CanvasOptionWidget extends StatelessWidget {
  final Function(CanvasOption) onSelect;
  CanvasOptionWidget({Key key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      PopupMenuButton<CanvasOption>
        (
        onSelected: onSelect,
        icon:const ElevatedButton(
          child: Icon(Icons.now_wallpaper)
        ),
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<CanvasOption>>[
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.flipX,
            child: ListTile(
                leading:Icon(Icons.vertical_split),
                title:Text("左右反転")
            ),
          ),
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.flipY,
            child: ListTile(
                leading:Icon(Icons.horizontal_split),
                title:Text("上下反転")
            ),
          ),
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.rotateL,
            child: ListTile(
                leading:Icon(Icons.rotate_left),
                title:Text("右に90度回転")
            ),
          ),
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.rotateL,
            child: ListTile(
                leading:Icon(Icons.rotate_right),
                title:Text("右に90度回転")
            ),
          ),
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.move,
            child: ListTile(
                leading:Icon(Icons.touch_app_sharp),
                title:Text("キャンバス移動")
            ),
          ),
        ],
      );
  }
}


enum FileOption{ save, load, editPalette,export,close}

class OptionWidget extends StatelessWidget {
  final Function(FileOption) onSelect;
  OptionWidget({Key key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FileOption>
        (
        onSelected: onSelect,
        icon:Icon(Icons.save),
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<FileOption>>[
         /* const PopupMenuItem<FileOption>(
            value: FileOption.save,
            child: ListTile(
                leading:Icon(Icons.save),
                title:Text("save")
            ),
          ),*/
          /*const PopupMenuItem<FileOption>(
            value: FileOption.load,
            child: ListTile(
                leading:Icon(Icons.file_download),
                title:Text("load")
            ),
          ),*/
          const PopupMenuItem<FileOption>(
            value: FileOption.editPalette,
            child: ListTile(
                leading:Icon(Icons.palette),
                title:Text("パレットを編集する")
            ),
          ),
          /*const PopupMenuItem<FileOption>(
            value: FileOption.export,
            child: ListTile(
                leading:Icon(Icons.outbox),
                title:Text("export")
            ),
          ),*/
          const PopupMenuItem<FileOption>(
            value: FileOption.close,
            child: ListTile(
                leading:Icon(Icons.close),
                title:Text("保存して終了")
            ),
          ),
        ],
      );
  }
}

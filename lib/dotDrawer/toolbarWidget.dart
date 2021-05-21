
import 'package:flutter/material.dart';

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

class ToolsWidget extends StatelessWidget {
  Function(int) onPressed;
  Function(CanvasOption) onCanvasOptionPressed;
  Function(FileOption) onFileOptionSelect;
  bool undoEnable = false;
  bool redoEnable = false;

  ToolsWidget(
      {Key key, this.onPressed, this.onCanvasOptionPressed, this.onFileOptionSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction:Axis.horizontal,
      children: [
        ElevatedButton(
            onPressed: () {
              onPressed(ToolsID.pen);
            },
            child: Icon(Icons.brush)
        ),
        ElevatedButton(
            onPressed: () {
              onPressed(ToolsID.bucket);
            },
            child: Icon(Icons.format_color_fill)
        ),
        ElevatedButton(
            onPressed: () {
              onPressed(ToolsID.rect);
            },
            child: Icon(Icons.crop_square)
        ),
        ElevatedButton(
            onPressed: () {
              onPressed(ToolsID.circle);
            },
            child: Icon(Icons.circle)
        ),
        ElevatedButton(
            onPressed: () {
              onPressed(ToolsID.line);
            },
            child: Icon(Icons.horizontal_rule_outlined)
        ),
        ElevatedButton(
            onPressed: () {
              onPressed(ToolsID.clear);
            },
            child: Icon(Icons.clear)
        ),
        ElevatedButton(
            onPressed: () {
              onPressed(ToolsID.spoit);
            },
            child: Icon(Icons.touch_app)
        ),
        CanvasOptionWidget(
          onSelect: onCanvasOptionPressed,
        ),
        ElevatedButton(
          onPressed: !undoEnable ? null : () {
            onPressed(ToolsID.undo);
          },
          child: Icon(Icons.undo),
        ),
        ElevatedButton(
            onPressed: !redoEnable ? null : () {
              onPressed(ToolsID.redo);
            },
            child: Icon(Icons.redo)
        ),
        OptionWidget(onSelect: onFileOptionSelect,)
      ],
    );
  }
}


enum CanvasOption{ flipX, flipY, rotateL,rotateR,move}

class CanvasOptionWidget extends StatelessWidget {
  Function(CanvasOption) onSelect;
  CanvasOptionWidget({Key key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      PopupMenuButton<CanvasOption>
        (
        onSelected: onSelect,
        icon:ElevatedButton(
          child: Icon(Icons.now_wallpaper)
        ),
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<CanvasOption>>[
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.flipX,
            child: ListTile(
                leading:Icon(Icons.vertical_split),
            ),
          ),
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.flipY,
            child: ListTile(
                leading:Icon(Icons.horizontal_split),
            ),
          ),
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.rotateL,
            child: ListTile(
                leading:Icon(Icons.rotate_left),
            ),
          ),
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.rotateL,
            child: ListTile(
                leading:Icon(Icons.rotate_right),
            ),
          ),
          const PopupMenuItem<CanvasOption>(
            value: CanvasOption.rotateL,
            child: ListTile(
                leading:Icon(Icons.touch_app_sharp),
            ),
          ),
        ],
      );
  }
}


enum FileOption{ save, load, editPalette,export,close}

class OptionWidget extends StatelessWidget {
  Function(FileOption) onSelect;
  OptionWidget({Key key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<FileOption>
        (
        onSelected: onSelect,
        icon:Icon(Icons.save),
        itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<FileOption>>[
          const PopupMenuItem<FileOption>(
            value: FileOption.save,
            child: ListTile(
                leading:Icon(Icons.save),
                title:Text("save")
            ),
          ),
          const PopupMenuItem<FileOption>(
            value: FileOption.load,
            child: ListTile(
                leading:Icon(Icons.file_download),
                title:Text("load")
            ),
          ),
          const PopupMenuItem<FileOption>(
            value: FileOption.editPalette,
            child: ListTile(
                leading:Icon(Icons.palette),
                title:Text("edit palette")
            ),
          ),
          const PopupMenuItem<FileOption>(
            value: FileOption.export,
            child: ListTile(
                leading:Icon(Icons.outbox),
                title:Text("export")
            ),
          ),
          const PopupMenuItem<FileOption>(
            value: FileOption.close,
            child: ListTile(
                leading:Icon(Icons.close),
                title:Text("close")
            ),
          ),
        ],
      );
  }
}

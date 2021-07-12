
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/tools.dart';
import 'package:flutter_app/theme.dart';

import 'ToolButton.dart';

class ToolsWidget extends StatelessWidget {
  final Function(ToolID) onPressed;
  final Function(CanvasOption) onCanvasOptionPressed;
  final Function(FileOption) onFileOptionSelect;
  final bool undoEnable;

  final bool redoEnable;

  final ToolID selectedTool;

  ToolsWidget(
      {Key key, this.onPressed, this.onCanvasOptionPressed, this.onFileOptionSelect, this.undoEnable, this.redoEnable, this.selectedTool})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        ToolButton(
          onPressed: () {
            onPressed(ToolID.pen);
          },
          icon: Icons.brush,
          isSelected: selectedTool == ToolID.pen,
        ),
        ToolButton(
          onPressed: () {
            onPressed(ToolID.bucket);
          },
          icon: Icons.format_color_fill,
          isSelected: selectedTool == ToolID.bucket,
        ),
        ToolButton(
          onPressed: () {
            onPressed(ToolID.rect);
          },
          icon: Icons.crop_square,
          isSelected: selectedTool == ToolID.rect,
        ),
        ToolButton(
          onPressed: () {
            onPressed(ToolID.line);
          },
          icon: Icons.horizontal_rule_outlined,
          isSelected: selectedTool == ToolID.line,
        ),
        ToolButton(
          onPressed: () {
            onPressed(ToolID.circle);
          },
          icon: Icons.circle,
          isSelected: selectedTool == ToolID.circle,
        ),
        ToolButton(
          onPressed: () {
            onPressed(ToolID.clear);
          },
          icon: Icons.clear,
          isSelected: false,
        ),
        ToolButton(
          onPressed: () {
            onPressed(ToolID.spoit);
          },
          icon: Icons.touch_app,
          isSelected: selectedTool==ToolID.spoit,
        ),
        CanvasOptionWidget(
          onSelect: onCanvasOptionPressed,
        ),
        ToolButton(
          onPressed: !undoEnable ? null : () {
            onPressed(ToolID.undo);
          },
          icon: Icons.undo,
          isSelected: false,
        ),
        ToolButton(
          onPressed: !redoEnable ? null : () {
            onPressed(ToolID.redo);
          },
          icon: Icons.redo,
          isSelected: false,
        ),
        ToolButton(
          onPressed: () {
            onPressed(ToolID.move);
          },
          icon: Icons.touch_app_sharp,
          isSelected: selectedTool == ToolID.move,
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
         /* const PopupMenuItem<CanvasOption>(
            value: CanvasOption.move,
            child: ListTile(
                leading:Icon(Icons.touch_app_sharp),
                title:Text("キャンバス移動")
            ),
          ),*/
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


enum SelectionOption{rect,magicWand}
class SelectionWidget extends StatelessWidget {

  final Function(SelectionOption) onSelect;
  SelectionWidget({Key key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SelectionOption>
      (
      onSelected: onSelect,
      icon:Icon(Icons.select_all_rounded),
      itemBuilder: (BuildContext context) =>
      <PopupMenuEntry<SelectionOption>>[
        const PopupMenuItem<SelectionOption>(
          value: SelectionOption.rect,
          child: ListTile(
              leading:Icon(Icons.select_all_rounded),
              title:Text("矩形選択")
          ),
        ),
        const PopupMenuItem<SelectionOption>(
          value: SelectionOption.magicWand,
          child: ListTile(
              leading:Icon(Icons.star),
              title:Text("マジックワンド")
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/palette.dart';
import 'package:flutter_app/dotDrawer/paletteEditor.dart';
import 'package:flutter_app/dotDrawer/toolbarWidget.dart';
import 'package:path_provider/path_provider.dart';

import '../encodeImg.dart';
import 'brush/basebrush.dart';
import 'brush/brushFactory.dart';
import 'brush/paint.dart';
import 'canvasHistory.dart';
import 'canvasPainter.dart';
import 'paletteWidget.dart';
import 'dotcanvas.dart';

import 'package:fluttertoast/fluttertoast.dart';

GlobalKey globalKey = GlobalKey();

class MainEditorWidget extends StatefulWidget {
  MainEditorWidget({Key key, this.dotCanvas,this.palette,this.onSave}) : super(key: key);
  DotCanvas dotCanvas;
  ColorPalette palette;
  Function onSave;

  @override
  _MainEditorWidgetState createState() => _MainEditorWidgetState();
}

class _MainEditorWidgetState extends State<MainEditorWidget> {
  var containerKey = GlobalKey();
  Cell currentCell;
  BaseBrush brush;
  CanvasHistory history;
  ToolsWidget tools;

  @override
  void initState() {
    super.initState();
    brush = PaintBrush(widget.dotCanvas, widget.palette);
    history = CanvasHistory(widget.dotCanvas.sizeX, widget.dotCanvas.sizeY);
    addHistory();
  }

  @override
  Widget build(BuildContext context) {
    tools = ToolsWidget(
      onPressed: this._changeTools,
      onCanvasOptionPressed: this.onCanvasOptionSelected,
      onFileOptionSelect: this.onOptionSelected,
    );
    tools.redoEnable = history.canRedo();
    tools.undoEnable = history.canUndo();

    return Scaffold(
        body: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: 500,
                  child: Column(
                    children: [
                      getCanvas(),
                      PaletteWidget(
                        onButtonPressed: this._changeColor,
                        onEditorOpen:this.openPaletteEditor,
                        palette: widget.palette,
                      ),
                      tools,
                    ],
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                      children: [
                        Text(
                          "history current index:" +
                              history.currentIndex.toString(),
                        ),
                        Text(
                          "history length:" +
                              history.stack.length.toString(),
                        ),
                        Text(
                          "is editing:" +
                              widget.dotCanvas.isEditing.toString(),
                        ),
                      ]
                  ),
                ),
              ),
            ]
        )
    );
  }

  Widget getCanvas() {
    return AspectRatio(
      aspectRatio: widget.dotCanvas.sizeX / widget.dotCanvas.sizeY,
      child: GestureDetector(
          key: globalKey,
          onTapDown: _addPointTap,
          onPanStart: _onPanStart,
          onPanUpdate: _addPointDrag,
          onPanEnd: _onPressExit,
          child: Container(
            width: 500,
            height: 500,
            margin:const EdgeInsets.all(10.0),
            child: CustomPaint(
              painter: CanvasPainter(
                  this.widget.dotCanvas, this.widget.palette
              ),
            ),
          )
      ),
    );
  }
void openPaletteEditor() {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        (
            PaletteEditor(canvas: widget.dotCanvas,palette: widget.palette,)
        ),
      )
  );
}
  void _changeTools(int type) {
    if (type == ToolsID.pen) {
      setBrush(BrushType.pen);
    }
    else if (type == ToolsID.bucket) {
      setBrush(BrushType.bucket);
    } else if (type == ToolsID.rect) {
      setBrush(BrushType.rect);
    } else if (type == ToolsID.circle) {
      setBrush(BrushType.circle);
    }
    else if (type == ToolsID.undo) {
      undo();
    } else if (type == ToolsID.redo) {
      redo();
    } else if (type == ToolsID.clear) {
      widget.dotCanvas.clear();
      addHistory();
    } else if (type == ToolsID.line) {
      setBrush(BrushType.line);
    } else if (type == ToolsID.spoit) {
     setBrush(BrushType.spoit);
    }
  }

  void onCanvasOptionSelected(CanvasOption value) {
    setState(() {
      if (value == CanvasOption.flipX) {
        widget.dotCanvas.reverseX();
        addHistory();
      }
      else if (value == CanvasOption.flipY) {
        widget.dotCanvas.reverseY();
        addHistory();
      }
      else if (value == CanvasOption.rotateL) {
        widget.dotCanvas.rotateLeft();
        addHistory();
      }
      else if (value == CanvasOption.rotateR) {
        widget.dotCanvas.rotateRight();
        addHistory();
      }
      else if (value == CanvasOption.move) {
        setBrush(BrushType.move);
      }
    });
  }

  void onOptionSelected(FileOption option) {
    if (option == FileOption.save) {
      widget.onSave();
    } else if (option == FileOption.load) {

    }
    else if (option == FileOption.editPalette) {
      this.openPaletteEditor();
    } else if (option == FileOption.export) {
      //ちゃんとディレクトリ指定しないと許可がないのでエラー
      getTemporaryDirectory().then((directory) {
        try {
          encodePNG(
              directory.path + "/test.png",
              widget.dotCanvas.sizeX,
              widget.dotCanvas.sizeY,
              widget.dotCanvas.normal.ids,
              widget.palette.convert(),
              16,
              16);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('png exported'),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e),
            ),
          );
        }
      });
    } else if (option == FileOption.close) {
      Navigator.pop(context);
    }
  }

  void _changeColor(int id) {
    widget.palette.currentColor = id;
  }

  void addHistory(){
    history.add(widget.dotCanvas.normal.ids);
  }

  void _addPointTap(TapDownDetails details) {
    Cell pos = toPosition(details.localPosition);
    setState(() {
      brush.onPressEnter(pos.x, pos.y);
      brush.onPressExit(pos.x, pos.y);
      addHistory();
    });
  }

  void _onPanStart(DragStartDetails details) {
    Cell pos = toPosition(details.localPosition);
    setState(() {
      brush.onPressEnter(pos.x, pos.y);
    });
    currentCell = Cell(pos.x, pos.y);
  }

  void _addPointDrag(DragUpdateDetails details) {
    Cell pos = toPosition(details.localPosition);
    setState(() {
      brush.onPress(pos.x, pos.y);
    });
    currentCell = Cell(pos.x, pos.y);
  }

  void _onPressExit(DragEndDetails details) {
    setState(() {
      brush.onPressExit(currentCell.x, currentCell.y);
      addHistory();
    });
  }

  Cell toPosition(Offset position) {
    RenderBox box = globalKey.currentContext.findRenderObject();
    double rectSizeX = box.size.width / widget.dotCanvas.sizeX;
    double rectSizeY = box.size.height / widget.dotCanvas.sizeY;
    var x = (position.dx / rectSizeX).floor();
    var y = (position.dy / rectSizeY).floor();
    return Cell(x, y);
  }

  void setBrush(BrushType type){
    brush =BrushFactory.getBrush(type,widget.dotCanvas,widget.palette);
  }

  void undo() {
    List<int> prev = history.pop();
    setState(() {
      for (int i = 0; i < prev.length; i++) {
        widget.dotCanvas.preview.ids[i] = prev[i];
      }
      widget.dotCanvas.apply();
    });
  }

  void redo() {
    List<int> next = history.back();
    setState(() {
      for (int i = 0; i < next.length; i++) {
        widget.dotCanvas.preview.ids[i] = next[i];
      }
      widget.dotCanvas.apply();
    });
  }

}

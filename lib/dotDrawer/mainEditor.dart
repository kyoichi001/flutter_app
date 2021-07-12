
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';
import 'package:flutter_app/dotDrawer/palette/paletteEditorPage.dart';
import 'package:flutter_app/dotDrawer/toolbarWidget.dart';
import 'package:flutter_app/dotDrawer/tools.dart';

import 'brush/basebrush.dart';
import 'brush/brushFactory.dart';
import 'brush/paint.dart';
import 'canvas/canvasHistory.dart';
import 'canvas/canvasPainter.dart';
import 'palette/paletteWidget.dart';
import 'canvas/dotcanvas.dart';

GlobalKey globalKey = GlobalKey();

class MainEditorWidget extends StatefulWidget {
  MainEditorWidget({Key key, this.dotCanvas,this.palette,this.onSave,this.onExport}) : super(key: key);
  DotCanvas dotCanvas;
  ColorPalette palette;
  Function onSave;
  Function onExport;

  @override
  _MainEditorWidgetState createState() => _MainEditorWidgetState();
}

class _MainEditorWidgetState extends State<MainEditorWidget> {
  var containerKey = GlobalKey();
  Cell currentCell;
  CanvasHistory history;
  ToolsWidget tools;
  CanvasTools canvasTools;

  @override
  void initState() {
    super.initState();
    history = CanvasHistory(widget.dotCanvas.sizeX, widget.dotCanvas.sizeY);
    addHistory(); //初期状態を記録
    canvasTools = CanvasTools(undo, redo,widget.dotCanvas,widget.palette,history);
  }

  @override
  Widget build(BuildContext context) {
    tools = ToolsWidget(
      onPressed: (ToolID id) {
        setState(() {
          canvasTools.set( id);
        });
      },
      onCanvasOptionPressed: this.onCanvasOptionSelected,
      onFileOptionSelect: this.onOptionSelected,
      undoEnable: history.canUndo(),
      redoEnable: history.canRedo(),
      selectedTool: canvasTools.currentTool,
    );

    return WillPopScope(
        onWillPop: () async {
          widget.onSave();
          return Future.value(true);
        },
        child: Scaffold(
            body: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 50, 3, 3),
                      padding: EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  "images/transparent.png",
                                  repeat: ImageRepeat.repeat,
                                ),
                              ),
                              getCanvas(),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: PaletteWidget(
                              onButtonPressed: this._changeColor,
                              //onEditorOpen: this.openPaletteEditor,
                              palette: widget.palette,
                            ),
                          ),
                          const Divider(
                            height: 5,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: tools,
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
          onPanUpdate: _onPan,
          onPanEnd: _onPanEnd,
          child: Container(
            width: 500,
            height: 500,
            margin: const EdgeInsets.all(0.0),
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
              PaletteEditorPage(canvas: widget.dotCanvas, palette: widget.palette,)
          ),
        )
    );
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
    });
  }

  void onOptionSelected(FileOption option) async {
    if (option == FileOption.save) {
      widget.onSave();
    } else if (option == FileOption.load) {//画像からよみこみ

    }
    else if (option == FileOption.editPalette) {
      this.openPaletteEditor();
    } else if (option == FileOption.export) {
      widget.onExport();
    } else if (option == FileOption.close) {
      await widget.onSave();
      Navigator.pop(context,true);
    }
  }

  void _changeColor(int id) {
    setState(() {
      widget.palette.currentColor = id;
    });
  }

  void addHistory() {
    history.add(widget.dotCanvas.normal.ids);
  }

  void _addPointTap(TapDownDetails details) {
    print("on tap");
    Cell pos = toPosition(details.localPosition);
    setState(() {
      canvasTools.currentBrush.onPressEnter(pos.x, pos.y);
      canvasTools.currentBrush.onPressExit(pos.x, pos.y);
      addHistory();
    });
  }

  void _onPanStart(DragStartDetails details) {
    print("on pan start");
    Cell pos = toPosition(details.localPosition);
    setState(() {
      canvasTools.currentBrush.onPressEnter(pos.x, pos.y);
    });
    currentCell = Cell(pos.x, pos.y);
  }

  void _onPan(DragUpdateDetails details) {
    print("on drag");
    Cell pos = toPosition(details.localPosition);
    setState(() {
      canvasTools.currentBrush.onPress(pos.x, pos.y);
    });
    currentCell = Cell(pos.x, pos.y);
  }

  void _onPanEnd(DragEndDetails details) {
    print("on pan end");
    setState(() {
      canvasTools.currentBrush.onPressExit(currentCell.x, currentCell.y);
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

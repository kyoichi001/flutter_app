
import 'package:flutter/material.dart';
import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/canvas/canvasHistory.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

import 'brush/brushFactory.dart';

enum ToolID {
  pen,
  bucket,
  rect,
  circle,
  undo,
  redo,
  canvas,
  reverseX,
  reverseY,
  move,
  rotateL,
  rotateR,
  clear,
  spoit,
  line,
}

class CanvasTools {
  ToolID currentTool = ToolID.pen;
  BaseBrush currentBrush;

  Function onUndo;
  Function onRedo;

  DotCanvas canvas;
  ColorPalette palette;
  CanvasHistory history;

  CanvasTools(this.onUndo, this.onRedo, this.canvas, this.palette,
      this.history) {
    setBrush(BrushType.pen);
  }

  void set(ToolID id) {
    switch (id) {
      case ToolID.pen:
        currentTool = id;
        setBrush(BrushType.pen);
        break;
      case ToolID.bucket:
        currentTool = id;
        setBrush(BrushType.bucket);
        break;
      case ToolID.rect:
        currentTool = id;
        setBrush(BrushType.rect);
        break;
      case ToolID.circle:
        currentTool = id;
        setBrush(BrushType.circle);
        break;
      case ToolID.undo:
        onUndo();
        break;
      case ToolID.redo:
        onRedo();
        break;
      case ToolID.clear:
        history.add(canvas.normal.ids);
        canvas.clear();
        break;
      case ToolID.line:
        currentTool = id;
        setBrush(BrushType.line);
        break;
      case ToolID.move:
        currentTool = id;
        setBrush(BrushType.move);
        break;
      case ToolID.spoit:
        currentTool = id;
        setBrush(BrushType.spoit);
        break;
      case ToolID.reverseX:
        canvas.reverseX();
        break;
      case ToolID.reverseY:
        canvas.reverseY();
        break;
      case ToolID.rotateL:
        canvas.rotateLeft();
        break;
      case ToolID.rotateR:
        canvas.rotateRight();
        break;
      default:
        break;
    }
  }

  void setBrush(BrushType type) {
    currentBrush = BrushFactory.getBrush(type, canvas, palette);
  }

  bool isIndexSelected(ToolID index) {
    return index == currentTool;
  }
}
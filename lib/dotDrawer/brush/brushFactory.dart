
import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/brush/paint.dart';
import 'package:flutter_app/dotDrawer/brush/rect.dart';
import 'package:flutter_app/dotDrawer/brush/spoit.dart';
import 'package:flutter_app/dotDrawer/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette.dart';

import 'bucket.dart';
import 'circle.dart';
import 'line.dart';
import 'move.dart';

enum BrushType {
  pen,
  eracer,
  bucket,
  rect,
  circle,
  line,
  spoit,
  move,
}

class BrushFactory{

  static BaseBrush getBrush(BrushType type,DotCanvas canvas,ColorPalette palette) {
    if (type == BrushType.pen) {
      return PaintBrush(canvas, palette);
    }
    else if (type == BrushType.bucket) {
      return BucketBrush(canvas, palette);
    }
    else if (type == BrushType.rect) {
      return RectBrush(canvas, palette);
    }
    else if (type == BrushType.circle) {
      return CircleBrush(canvas, palette);
    }
    else if (type == BrushType.line) {
      return LineBrush(canvas, palette);
    }
    else if (type == BrushType.spoit) {
      return SpoitBrush(canvas, palette);
    }
    else if (type == BrushType.move) {
      return MoveBrush(canvas, palette);
    }
    return null;
  }
}
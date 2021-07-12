
import 'package:flutter_app/dotDrawer/brush/basebrush.dart';
import 'package:flutter_app/dotDrawer/brush/paint.dart';
import 'package:flutter_app/dotDrawer/brush/rect.dart';
import 'package:flutter_app/dotDrawer/brush/spoit.dart';
import 'package:flutter_app/dotDrawer/canvas/dotcanvas.dart';
import 'package:flutter_app/dotDrawer/palette/palette.dart';

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

class BrushFactory {

  static BaseBrush getBrush(BrushType type, DotCanvas canvas,
      ColorPalette palette) {
    switch (type) {
      case BrushType.bucket:
        return BucketBrush(canvas, palette);
      case BrushType.circle:
        return CircleBrush(canvas, palette);
      case BrushType.eracer:
        return null;
      case BrushType.line:
        return LineBrush(canvas, palette);
      case BrushType.move:
        return MoveBrush(canvas, palette);
      case BrushType.pen:
        return PaintBrush(canvas, palette);
      case BrushType.rect:
        return RectBrush(canvas, palette);
      case BrushType.spoit:
        return SpoitBrush(canvas, palette);
    }
    return null;
  }
}
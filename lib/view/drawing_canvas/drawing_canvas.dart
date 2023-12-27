import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pixel_work_1/main.dart';
import 'package:pixel_work_1/view/drawing_canvas/models/drawing_mode.dart';
import 'package:pixel_work_1/view/drawing_canvas/models/sketch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_work_1/view/drawing_page.dart';

class DrawingCanvas extends HookWidget {
  final double height;
  final double width;
  final ValueNotifier<Color> selectedColor;
  final double strokeSize;
  final ValueNotifier<Image?> backgroundImage;
  final ValueNotifier<double> eraserSize;
  final ValueNotifier<DrawingMode> drawingMode;
  final AnimationController sideBarController;
  final ValueNotifier<Sketch?> currentSketch;
  final ValueNotifier<List<Sketch>> allSketches;
  final GlobalKey canvasGlobalKey;
  final ValueNotifier<int> polygonSides;
  final bool filled;

  const DrawingCanvas({
    Key? key,
    required this.height,
    required this.width,
    required this.selectedColor,
    required this.strokeSize,
    required this.eraserSize,
    required this.drawingMode,
    required this.sideBarController,
    required this.currentSketch,
    required this.allSketches,
    required this.canvasGlobalKey,
    required this.filled,
    required this.polygonSides,
    required this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = 1000.toPXLength;
    log(value.toString(), name: "value");
    return MouseRegion(
      cursor: SystemMouseCursors.precise,
      child: Stack(
        children: [
          buildAllSketches(context),
          buildCurrentPath(context),
        ],
      ),
    );
  }

/*   void onPointerDown(PointerDownEvent details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);
    currentSketch.value = Sketch.fromDrawingMode(
      Sketch(
        points: [offset],
        size: strokeSize,
        color: selectedColor.value,
        sides: polygonSides.value,
      ),
      drawingMode.value,
      filled,
    );
  } */

/*   void onPointerMove(PointerMoveEvent details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);
    final points = List<Offset>.from(currentSketch.value?.points ?? [])
      ..add(offset);

    currentSketch.value = Sketch.fromDrawingMode(
      Sketch(
        points: points,
        size: drawingMode.value == DrawingMode.eraser
            ? eraserSize.value
            : strokeSize,
        color: drawingMode.value == DrawingMode.eraser
            ? kCanvasColor
            : selectedColor.value,
        sides: polygonSides.value,
      ),
      drawingMode.value,
      filled, S
    );
  } */

  void onPointerUp(PointerUpEvent details, BuildContext context) {
    /*    allSketches.value = List<Sketch>.from(allSketches.value)
      ..add(currentSketch.value!);
    currentSketch.value = Sketch.fromDrawingMode(
      Sketch(
        points: [],
        size: strokeSize, 
        color: selectedColor.value,
        sides: polygonSides.value,
      ),
      drawingMode.value,
      filled,
    ); */

    final box = context.findRenderObject() as RenderBox;
    final offset = box.globalToLocal(details.position);

    offset.dy + 100;
    currentSketch.value = Sketch.fromDrawingMode(
      Sketch(
        points: [Offset(offset.dx - 50, offset.dy - 50)],
        size: strokeSize,
        color: selectedColor.value,
        sides: polygonSides.value,
      ),
      drawingMode.value,
      filled,
    );
  }

  Widget buildAllSketches(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ValueListenableBuilder<List<Sketch>>(
        valueListenable: allSketches,
        builder: (context, sketches, _) {
          return RepaintBoundary(
            key: canvasGlobalKey,
            child: Container(
              height: height,
              width: width,
              color: kCanvasColor,
              child: CustomPaint(
                painter: SketchPainter(
                  sketches: sketches,
                  backgroundImage: backgroundImage.value,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    return Listener(
      // sonPointerDown: (details) => onPointerDown(details, context),
      //onPointerMove: (details) /* => onPointerMove(details, context) */,
      onPointerUp: (details) => onPointerUp(details, context),
      child: ValueListenableBuilder(
        valueListenable: currentSketch,
        builder: (context, sketch, child) {
          return RepaintBoundary(
            child: SizedBox(
              height: height,
              width: width,
              child: CustomPaint(
                painter: SketchPainter(
                  sketches: sketch == null ? [] : [sketch],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Sketch> sketches;
  final Image? backgroundImage;

  const SketchPainter({
    Key? key,
    this.backgroundImage,
    required this.sketches,
  });

  @override
  Future<void> paint(Canvas canvas, Size size) async {
/*     if (backgroundImage != null) {  draw image olayı yani resim ekleme
      canvas.drawImageRect(
        backgroundImage!,
        Rect.fromLTWH(
          0,
          0,
          backgroundImage!.width.toDouble(),
          backgroundImage!.height.toDouble(),
        ),
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint(),
      );
    } */
    for (Sketch sketch in sketches) {
      final points = sketch.points;
      if (points.isEmpty) return;

      final path = Path();
      /*
      path.moveTo(points[0].dx, points[0].dy);
      if (points.length < 2) {
        // If the path only has one line, draw a dot.
        log(points[0].dx.toString(), name: "dx");
        log(points[0].dy.toString(), name: "dy"); */

/*         path.addOval(
          Rect.fromCircle(
            center: Offset(points[0].dx, points[0].dy),
            radius: 0,
          ),
        ); 
      }*/

      Paint paint2 = Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.butt
        ..strokeWidth = 1
        ..style = PaintingStyle.fill;

      // 1 piksel nokta çizimi
      Offset point = Offset(points[0].dx, points[0].dy);

      canvas.drawPoints(PointMode.points, [point], paint2);

      log(points[0].dx.toString(), name: "points[0].dx");
      log(points[0].dy.toString(), name: "points[0].dy");

/*       for (var y = 0; y < 1250; y++) { yukarıdan aşağı nokta atar
        log(y.toString(), name: "y");
        Paint paint2 = Paint()
          ..color = Colors.black
          ..strokeCap = StrokeCap.square
          ..strokeWidth = getPixel(1)
          ..style = PaintingStyle.fill;
        Offset point = Offset(getPixel(100), getPixel(y.toDouble()));

        canvas.drawPoints(PointMode.points, [point], paint2);
      }
 */

      for (int i = 1; i < points.length - 1; ++i) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.quadraticBezierTo(
          p0.dx,
          p0.dy,
          (p0.dx + p1.dx) / 2,
          (p0.dy + p1.dy) / 2,
        );
      }

      Paint paint = Paint()
        ..color = sketch.color
        ..strokeCap = StrokeCap.square;

      if (!sketch.filled) {
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = sketch.size;
      }

      // define first and last points for convenience
      Offset firstPoint = sketch.points.first;
      Offset lastPoint = sketch.points.last;

      // create rect to use rectangle and circle
      Rect rect = Rect.fromPoints(firstPoint, lastPoint);

      // Calculate center point from the first and last points
      Offset centerPoint = (firstPoint / 2) + (lastPoint / 2);

      // Calculate path's radius from the first and last points
      double radius = (firstPoint - lastPoint).distance / 2;

      if (sketch.type == SketchType.scribble) {
        canvas.drawPath(path, paint);
      } else if (sketch.type == SketchType.square) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
          paint,
        );
      } else if (sketch.type == SketchType.line) {
        canvas.drawLine(firstPoint, lastPoint, paint);
      } else if (sketch.type == SketchType.circle) {
        canvas.drawOval(rect, paint);
        // Uncomment this line if you need a PERFECT CIRCLE
        // canvas.drawCircle(centerPoint, radius , paint);
      } else if (sketch.type == SketchType.polygon) {
        Path polygonPath = Path();
        int sides = sketch.sides;
        var angle = (math.pi * 2) / sides;

        double radian = 0.0;

        Offset startPoint =
            Offset(radius * math.cos(radian), radius * math.sin(radian));

        polygonPath.moveTo(
          startPoint.dx + centerPoint.dx,
          startPoint.dy + centerPoint.dy,
        );
        for (int i = 1; i <= sides; i++) {
          double x = radius * math.cos(radian + angle * i) + centerPoint.dx;
          double y = radius * math.sin(radian + angle * i) + centerPoint.dy;
          polygonPath.lineTo(x, y);
        }
        polygonPath.close();
        canvas.drawPath(polygonPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SketchPainter oldDelegate) {
    return oldDelegate.sketches != sketches;
  }
}

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pixel_work_1/main.dart';
import 'package:pixel_work_1/view/drawing_canvas/drawing_canvas.dart';
import 'package:pixel_work_1/view/drawing_canvas/models/drawing_mode.dart';
import 'package:pixel_work_1/view/drawing_canvas/models/sketch.dart';
import 'package:pixel_work_1/view/drawing_canvas/widgets/canvas_side_bar.dart';

class DrawingPage extends HookWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);

    final canvasGlobalKey = GlobalKey();

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            width: double.maxFinite,
            height: double.maxFinite,
            child: DrawingCanvas(
              width: getPixel(1000),
              height: getPixel(1000),
              drawingMode: drawingMode,
              selectedColor: selectedColor,
              strokeSize: getPixel(0.01),
              eraserSize: eraserSize,
              sideBarController: animationController,
              currentSketch: currentSketch,
              allSketches: allSketches,
              canvasGlobalKey: canvasGlobalKey,
              filled: true,
              polygonSides: polygonSides,
              backgroundImage: backgroundImage,
            ),
          ),
          Positioned(
              top: getPixel(1000) + 10,
              left: getPixel(1000) / 2,
              child: const Text("1000px")),
          Positioned(
              top: getPixel(1000) / 2,
              left: getPixel(1000) + 10,
              child: const RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    "1000px",
                  ))),
          /*     Positioned(
            top: kToolbarHeight + 50, 
            // left: -5,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(animationController),
              child: CanvasSideBar(
                drawingMode: drawingMode,
                selectedColor: selectedColor,
                strokeSize: strokeSize,
                eraserSize: eraserSize,
                currentSketch: currentSketch,
                allSketches: allSketches,
                canvasGlobalKey: canvasGlobalKey,
                filled: filled,
                polygonSides: polygonSides,
                backgroundImage: backgroundImage,
              ),
            ),
          ),
          _CustomAppBar(animationController: animationController), */
        ],
      ),
    );
  }
}

double getPixel(double value) {
  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
  return (value / view.devicePixelRatio);
}

class _CustomAppBar extends StatelessWidget {
  final AnimationController animationController;

  const _CustomAppBar({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (animationController.value == 0) {
                  animationController.forward();
                } else {
                  animationController.reverse();
                }
              },
              icon: const Icon(Icons.menu),
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

const double menuHeight = 60;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Stack(children: <Widget>[
            CustomPaint(
                painter: Editor(),
                child: const Center(
                  child: Text(
                    'Once upon a time...',
                  ),
                )),
            const Text("ciao"),
            const Positioned(
                bottom: 0,
                child: SizedBox(height: menuHeight, child: Text("MENU"))),
          ]),
        ),
      ),
    );
  }
}

class Editor extends CustomPainter {
  int zoom = 1;
  int width = 64;
  int height = 64;
  double minSize = 0;
  double gridSize = 0;

  Paint p = Paint()
    ..color = const Color(0xffff0000)
    ..strokeWidth = 5;
  Paint p2 = Paint()
    ..color = const Color(0xffffff00)
    ..strokeWidth = 5;

  @override
  void paint(Canvas canvas, Size size) {
    //canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), p);

    // keep space for menu on bottom
    Size ns = Size(size.width, size.height - menuHeight);

    if (size.width > size.height) {
      minSize = (ns.height - ns.height % height);
      gridSize = minSize / height;
    } else {
      minSize = (ns.width - ns.width % width);
      gridSize = minSize / width;
    }
    assert(minSize > 0);
    assert(gridSize > 0);

    for (double x = 0; x <= gridSize; x++) {
      lineVertical(canvas, x);
    }

    for (double y = 0; y <= gridSize; y++) {
      lineHoriz(canvas, y);
    }

    for (int x = 0; x < gridSize; x++)
      for (int y = 0; y < gridSize; y++) {
        drawPixel(canvas, x, y, p2);
      }

    print("${gridSize * width}");
    print("${gridSize * height}");
    print("minSize: $minSize");
  }

  void lineVertical(Canvas canvas, double x) {
    Offset start = Offset(x * (width), 0);
    Offset end = Offset(x * (width), minSize);

    canvas.drawLine(
      start,
      end,
      p,
    );
    canvas.drawCircle(start, 5, p);
    canvas.drawCircle(end, 5, p);
  }

  void lineHoriz(Canvas canvas, double y) {
    Offset start = Offset(0, y * (height));
    Offset end = Offset(minSize, y * (height));

    canvas.drawLine(
      start,
      end,
      p,
    );
    canvas.drawCircle(start, 5, p);
    canvas.drawCircle(end, 5, p);
  }

  void drawPixel(Canvas canvas, int x, int y, Paint p) {
    canvas.drawRect(
      Rect.fromLTWH(
        x.toDouble() * width,
        y.toDouble() * height,
        width.toDouble(),
        height.toDouble(),
      ),
      p,
    );
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}

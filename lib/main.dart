import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pixel_work_1/view/drawing_page.dart';

void main() {
  runApp(const MyApp());
}

const Color kCanvasColor = Color(0xfff2f3f7);
const String kGithubRepo = 'https://github.com/JideGuru/flutter_drawing_board';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Let\'s Draw',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: DrawingPage()),
    );
  }
}

/* 
import 'dart:ui';

import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';

const Color kCanvasColor = Color(0xfff2f3f7);
const String kGithubRepo = 'https://github.com/JideGuru/flutter_drawing_board';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toggle = true;

  late Dimension beginWidth;
  late Dimension beginHeight;
  late Dimension endWidth;
  late Dimension endHeight;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    beginWidth = Dimension.max(20.toPercentLength, 700.toPXLength);
    beginHeight = (90.toVHLength - 10.toPXLength);

    endWidth = Dimension.clamp(200.toPXLength, 40.toVWLength, 200.toPXLength);
    endHeight = 50.toVHLength +
        10.toPercentLength -
        Dimension.min(4.toPercentLength, 40.toPXLength);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dimension Demo"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            toggle = !toggle;
          });
        },
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.green,
        child: AnimatedDimensionSizedBox(
          duration: const Duration(seconds: 2),
          width: toggle ? beginWidth : endWidth,
          height: toggle ? beginHeight : endHeight,
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.amberAccent,
            child: DefaultTextStyle(
                style: const TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Screen Size: $screenSize"),
                      Text("Begin Width: $beginWidth"),
                      Text("End Width: $endWidth"),
                      Text(
                          "Begin Width in PX: ${beginWidth.toPX(constraint: screenSize.width, screenSize: screenSize)}, End Width in PX: ${endWidth.toPX(constraint: screenSize.width, screenSize: screenSize)}"),
                      Text("Begin Height: $beginHeight"),
                      Text("End Height: $endHeight"),
                      Text(
                          "Begin Height in PX: ${beginHeight.toPX(constraint: screenSize.height, screenSize: screenSize)}, End Height in PX: ${endHeight.toPX(constraint: screenSize.height, screenSize: screenSize)}"),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DimensionSizedBox(
                          width: 50.toPercentLength,
                          height: 50.toPercentLength,
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
 */
class DEnemebox extends StatelessWidget {
  const DEnemebox({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

// Dimensions in physical pixels (px)
    Size size = view.physicalSize;
    print(view.devicePixelRatio);
    double width = size.width;
    double height = size.height;
    final size2 = MediaQuery.of(context).size;
    print("size${1000 / view.devicePixelRatio}");
    print(width);
    return Container(
      height: getPixel(1000),
      width: getPixel(1000),
      color: Colors.red,
    ) /* DimensionSizedBox(
      height: 2.toPXLength,
      width: (size.width / 2).toPXLength,
      child: Container(color: Colors.red),
    ) */
        ;
  }

  double getPixel(double value) {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    return (value / view.devicePixelRatio);
  }
}

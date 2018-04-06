import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.light(),
      title: 'Animation Drink',
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      vsync: this,
      duration: new Duration(
        seconds: 3,
      ),
    );
    animation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          child: new CustomPaint(
            painter: new Artboard(
              value: animation.value,
            ),
          ),
        ),
      ),
    );
  }
}

class Artboard extends CustomPainter {
  Artboard({this.value});

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    // paint something

    

    //backgroundcircle
    var cirPaint = new Paint()
      ..color = Colors.tealAccent[200]
      ..blendMode = BlendMode.multiply;
    canvas.drawCircle(new Offset(-15.0, 10.0), 40.0, cirPaint);

    //square
    canvas.save();
    canvas.translate(80.0, -75.0);
    canvas.rotate(math.pi / 12);
    var sqaurePaint = new Paint()
      ..color = Colors.cyanAccent[100]
      ..blendMode = BlendMode.multiply;
    canvas.drawRect(
        new Rect.fromCircle(center: new Offset(0.0, 0.0), radius: 30.0),
        sqaurePaint);

    //purple triangle
    canvas.restore();
    canvas.save();
    canvas.rotate(value*math.pi*2);
    var triPath2 = new Path()
      ..moveTo(-90.0, -180.0) //2
      ..lineTo(30.0, -100.0) //3
      ..lineTo(-100.0, -40.0); //1;
    var triPaint2 = new Paint()
      ..color = Colors.purple[200]
      ..blendMode = BlendMode.multiply;

    canvas.drawPath(triPath2, triPaint2);

    canvas.restore();
    //main ball
    var mainCircle = new Paint()..color = Colors.green[300];
    canvas.drawCircle(new Offset(0.0, value * (800) - 380), 50.0, mainCircle);

    //lower box
    var boxPath2 = new Path();
    var boxPaint2 = new Paint()..color = Colors.deepPurple[300];

    boxPath2.addRect(
        new Rect.fromCircle(center: new Offset(0.0, 370.0), radius: 50.0));
    boxPath2.addRect(new Rect.fromLTWH(-60.0 + 120, 350.0, -120.0, 15.0));
    canvas.drawPath(boxPath2, boxPaint2);

    //upper box
    var boxPath = new Path();
    var boxPaint = new Paint()..color = Colors.deepPurple[300];

    boxPath.addRect(
        new Rect.fromCircle(center: new Offset(0.0, -350.0), radius: 50.0));
    boxPath.addRect(new Rect.fromLTWH(-60.0 + 120, -330.0, -120.0, 15.0));
    canvas.drawPath(boxPath, boxPaint);

    //red triangle
    
    canvas.rotate(math.pi/10*value);
    var triPath = new Path()
      ..moveTo(70.0, -70.0) //2
      ..lineTo(20.0, 100.0) //3
      ..lineTo(-60.0, -100.0); //1;
    var triPaint = new Paint()
    ..color = Colors.red[300]
    ..blendMode = BlendMode.multiply;

    canvas.drawPath(triPath, triPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

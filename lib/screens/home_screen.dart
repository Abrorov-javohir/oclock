import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime time = DateTime.now();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("HomeScreen"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: CustomPaint(
            size: const Size(double.infinity, 800),
            painter: MyPainter(time),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final DateTime time;
  MyPainter(this.time);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 10);
    final radius = 90.0;
//body
    final paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
//center circle
    final paint2 = Paint();
    paint2.color = Colors.amber;
    paint2.style = PaintingStyle.fill;
    canvas.drawCircle(center, 10, paint2);

    //hour paint  and hand
    final hourpaint = Paint();
    hourpaint.color = Colors.red;
    hourpaint.style = PaintingStyle.stroke;
    hourpaint.strokeWidth = 8;
    hourpaint.strokeCap = StrokeCap.round;

    final hourhandLength = radius * 0.7;
    final hourRadian = ((time.hour % 12) + time.minute / 60) * 30 * pi / 180;
    final hourhand = center.dx + hourhandLength * cos(hourRadian - pi / 2);
    final hourhand2 = center.dy + hourhandLength * cos(hourRadian - pi / 2);
    canvas.drawLine(center, Offset(hourhand, hourhand2), hourpaint);

    //minut paint and hand

    final minutePaint = Paint();
    minutePaint.color = Colors.green; // Minute hand color
    minutePaint.style = PaintingStyle.stroke;
    minutePaint.strokeWidth = 6;
    minutePaint.strokeCap = StrokeCap.round;

    final minuteHandLength = radius * 0.7;
    final minuteRadians = (time.minute + time.second / 60) * 6 * pi / 180;
    final minuteHandX =
        center.dx + minuteHandLength * cos(minuteRadians - pi / 2);
    final minuteHandY =
        center.dy + minuteHandLength * sin(minuteRadians - pi / 2);

    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), minutePaint);
    // Draw secund paint and hand
    final secondPaint = Paint();
    secondPaint.color = Colors.amber;
    secondPaint.style = PaintingStyle.stroke;
    secondPaint.strokeWidth = 4;
    secondPaint.strokeCap = StrokeCap.round;

    final secondHandLength = radius * 0.9;
    final secondRadians = time.second * 6 * pi / 180;
    final secondHandX =
        center.dx + secondHandLength * cos(secondRadians - pi / 2);
    final secondHandY =
        center.dy + secondHandLength * sin(secondRadians - pi / 2);

    canvas.drawLine(center, Offset(secondHandX, secondHandY), secondPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

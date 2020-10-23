import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';

class SecondHandPainter extends CustomPainter {
  final Paint secondHandPaint;

  int seconds;

  SecondHandPainter({this.seconds}) : secondHandPaint = Paint() {
    secondHandPaint.color = Palette.secondIndicator;
    secondHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * this.seconds / 60);

    canvas.drawCircle(Offset(0.0, (-radius * 0.85)-16), 8, secondHandPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(SecondHandPainter oldDelegate) {
    return this.seconds != oldDelegate.seconds;
  }
}

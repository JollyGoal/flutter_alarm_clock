import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';

class ClockDialPainter extends CustomPainter {
  final Paint tickPaint;

  final double tickLength = 10.0;
  final double tickWidth = 2.0;

  ClockDialPainter() : tickPaint = Paint() {
    tickPaint.color = Palette.tertiaryButton;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();

    // drawing
    canvas.translate(radius, radius);
    for (var i = 0; i < 60; i++) {
      //make the length and stroke of the tick marker longer and thicker depending
      tickMarkLength = tickLength;
      tickPaint.strokeWidth = tickWidth;
      canvas.drawLine(Offset(0.0, -radius),
          Offset(0.0, -radius + tickMarkLength), tickPaint);

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

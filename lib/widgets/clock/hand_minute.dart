import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';

class MinuteHandPainter extends CustomPainter {
  final Paint minuteHandPaint;
  int minutes;
  int seconds;

  MinuteHandPainter({
    this.minutes,
    this.seconds,
  }) : minuteHandPaint = Paint() {
    minuteHandPaint.color = Palette.minuteIndicator;
    minuteHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * ((this.minutes + (this.seconds / 60)) / 60));

    canvas.drawCircle(Offset(0.0, (-radius * 0.65)-12), 6, minuteHandPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}

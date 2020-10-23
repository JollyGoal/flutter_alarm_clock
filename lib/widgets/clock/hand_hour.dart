import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';

class HourHandPainter extends CustomPainter {
  final Paint hourHandPaint;
  int hours;
  int minutes;

  HourHandPainter({
    this.hours,
    this.minutes,
  }) : hourHandPaint = Paint() {
    hourHandPaint.color = Palette.hourIndicator;
    hourHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    // To draw hour hand
    canvas.save();

    canvas.translate(radius, radius);

    //checks if hour is greater than 12 before calculating rotation
    canvas.rotate(this.hours >= 12
        ? 2 * pi * ((this.hours - 12) / 12 + (this.minutes / 720))
        : 2 * pi * ((this.hours / 12) + (this.minutes / 720)));

    canvas.drawCircle(Offset(0.0, (-radius * 0.4)-8), 4, hourHandPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(HourHandPainter oldDelegate) {
    return true;
  }
}

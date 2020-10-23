import 'package:flutter/cupertino.dart';

class UtcOffset {
  // Sign can be "+" or "-"
  final String sign;
  final int hours;
  final int minutes;

  UtcOffset({
    @required this.sign,
    @required this.hours,
    this.minutes = 0,
  });
}

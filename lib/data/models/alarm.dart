import 'package:flutter/cupertino.dart';

class Alarm {
  bool isEnabled;
  final String time;
  final List<int> daysOfWeek;

  Alarm({
    @required this.isEnabled,
    @required this.time,
    this.daysOfWeek,
  });
}

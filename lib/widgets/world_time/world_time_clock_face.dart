import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class WorldTimeClockFace extends StatefulWidget {
  final UtcOffset utcOffset;
  final Duration updateDuration;

  const WorldTimeClockFace({
    Key key,
    @required this.utcOffset,
    this.updateDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _WorldTimeClockFaceState createState() => _WorldTimeClockFaceState();
}

class _WorldTimeClockFaceState extends State<WorldTimeClockFace> {
  Timer _timer;
  DateTime _dateTime;
  String _digits;

  void setTime(Timer timer) {
    setState(() {
      _dateTime = DateTime.now().toUtc();
      widget.utcOffset.sign == "+"
          ? _dateTime = _dateTime.add(Duration(
              hours: widget.utcOffset.hours, minutes: widget.utcOffset.minutes))
          : _dateTime = _dateTime.subtract(Duration(
              hours: widget.utcOffset.hours,
              minutes: widget.utcOffset.minutes));
      _digits =
          '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  void initState() {
    _dateTime = DateTime.now().toUtc();
    widget.utcOffset.sign == "+"
        ? _dateTime = _dateTime.add(Duration(
            hours: widget.utcOffset.hours, minutes: widget.utcOffset.minutes))
        : _dateTime = _dateTime.subtract(Duration(
            hours: widget.utcOffset.hours, minutes: widget.utcOffset.minutes));

    _digits =
        '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}';

    super.initState();
    this._timer = Timer.periodic(widget.updateDuration, setTime);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _digits,
      style: GoogleFonts.getFont(
        'Electrolize',
        textStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

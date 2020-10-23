import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'clock_face.dart';

import 'clock_dial_painter.dart';
import 'clock_hands.dart';

typedef TimeProducer = DateTime Function();

class Clock extends StatefulWidget {
  final Color circleColor;
  final Color shadowColor;
  final Color clockDialColor;
  final bool showDigits;
  final Duration updateDuration;

  Clock({
    @required this.circleColor,
    @required this.shadowColor,
    @required this.clockDialColor,
    this.showDigits = true,
    this.updateDuration = const Duration(milliseconds: 500),
  });

  @override
  State<StatefulWidget> createState() {
    return _Clock();
  }
}

class _Clock extends State<Clock> {
  Timer _timer;
  DateTime dateTime;
  String digits;

  @override
  void initState() {
    dateTime = DateTime.now();
    digits =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
    super.initState();
    this._timer = Timer.periodic(widget.updateDuration, setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = DateTime.now();
      digits =
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            ClockFace(
              circleColor: widget.circleColor,
              shadowColor: widget.shadowColor,
              clockDialColor: widget.clockDialColor,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: CustomPaint(
                painter: ClockDialPainter(),
              ),
            ),
            ClockHands(dateTime: dateTime),
            widget.showDigits
                ? Center(
                    child: Text(
                      digits,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Electrolize',
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

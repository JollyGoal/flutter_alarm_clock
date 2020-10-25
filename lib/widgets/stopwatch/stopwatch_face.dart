import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class StopwatchFace extends StatefulWidget {
  final Stopwatch stopwatchMain;
  final StreamController<StopwatchStatus> stopwatchStateController;

  const StopwatchFace({
    Key key,
    @required this.stopwatchMain,
    @required this.stopwatchStateController,
  }) : super(key: key);

  @override
  _StopwatchFaceState createState() => _StopwatchFaceState();
}

class _StopwatchFaceState extends State<StopwatchFace> {
  static const Duration _timerTick = const Duration(milliseconds: 10);
  Timer _timer;
  StreamSubscription _stopwatchSubscription;

  void handleStopwatchFaceUpdate(StopwatchStatus state) {
    switch (state) {
      case StopwatchStatus.initial:
        _timer?.cancel();
        setState(() {});
        break;
      case StopwatchStatus.paused:
        _timer?.cancel();
        setState(() {});
        break;
      case StopwatchStatus.running:
        _timer = Timer.periodic(_timerTick, setTime);
        break;
    }
  }

  void setTime(Timer timer) {
    // print('face tick');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.stopwatchMain.isRunning &&
        (_timer == null || !_timer.isActive)) {
      _timer = Timer.periodic(_timerTick, setTime);
    }
    _stopwatchSubscription = widget.stopwatchStateController.stream
        .listen((state) => handleStopwatchFaceUpdate(state));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.end,
      children: [
        widget.stopwatchMain.elapsed.inHours != 0
            ? SizedBox(
                width: 78,
                child: Text(
                  widget.stopwatchMain.elapsed.inHours
                          .toString()
                          .padLeft(2, "0"),
                  textAlign: TextAlign.end,
                  style: GoogleFonts.getFont(
                    'Electrolize',
                    textStyle: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            : SizedBox.shrink(),
        widget.stopwatchMain.elapsed.inHours != 0
            ? Text(
                ":",
                style: GoogleFonts.getFont(
                  'Electrolize',
                  textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : SizedBox.shrink(),
        SizedBox(
          width: 78,
          child: Text(
            (widget.stopwatchMain.elapsed.inMinutes -
                    (60 * widget.stopwatchMain.elapsed.inHours))
                .toString()
                .padLeft(2, "0"),
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont(
              'Electrolize',
              textStyle: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Text(
          ":",
          style: GoogleFonts.getFont(
            'Electrolize',
            textStyle: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 78,
          child: Text(
            (widget.stopwatchMain.elapsed.inSeconds -
                    (60 * widget.stopwatchMain.elapsed.inMinutes))
                .toString()
                .padLeft(2, "0"),
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont(
              'Electrolize',
              textStyle: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Text(
          ".",
          style: GoogleFonts.getFont(
            'Electrolize',
            textStyle: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 78,
          child: Text(
            widget.stopwatchMain.elapsed.inMilliseconds.toString().length > 2
                ? widget.stopwatchMain.elapsed.inMilliseconds
                    .toString()
                    .substring(
                        widget.stopwatchMain.elapsed.inMilliseconds
                                .toString()
                                .length -
                            3,
                        widget.stopwatchMain.elapsed.inMilliseconds
                                .toString()
                                .length -
                            1)
                : widget.stopwatchMain.elapsed.inMilliseconds
                    .toString()
                    .padLeft(2, "0"),
            textAlign: TextAlign.start,
            style: GoogleFonts.getFont(
              'Electrolize',
              textStyle: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatchSubscription?.cancel();
    super.dispose();
  }
}

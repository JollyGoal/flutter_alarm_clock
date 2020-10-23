import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:google_fonts/google_fonts.dart';

enum StopWatchStatus {
  initial,
  paused,
  running,
}

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key key}) : super(key: key);

  @override
  _StopWatchScreenState createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer _timer;
  Stopwatch _stopwatch;
  StopWatchStatus _stopwatchStatus;
  static const Duration _timerTick = const Duration(milliseconds: 10);
  String _minutesSeconds;

  @override
  void initState() {
    _stopwatchStatus = StopWatchStatus.initial;
    _stopwatch = Stopwatch();
    super.initState();
  }

  void setTime(Timer timer) {
    setState(() {});
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   _stopwatch.reset();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackground,
      bottomNavigationBar: buildBottomBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 180.0,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.end,
                children: [
                  _stopwatch.elapsed.inHours != 0
                      ? SizedBox(
                          width: 78,
                          child: Text(
                            _stopwatch.elapsed.inHours
                                    .toString()
                                    .padLeft(2, "0") +
                                ":",
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
                  _stopwatch.elapsed.inHours != 0 ? Text(
                    ":",
                    style: GoogleFonts.getFont(
                      'Electrolize',
                      textStyle: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ) : SizedBox.shrink(),
                  SizedBox(
                    width: 78,
                    child: Text(
                      (_stopwatch.elapsed.inMinutes -
                              (60 * _stopwatch.elapsed.inHours))
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
                      (_stopwatch.elapsed.inSeconds -
                              (60 * _stopwatch.elapsed.inMinutes))
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
                      _stopwatch.elapsed.inMilliseconds.toString().length > 2
                          ? _stopwatch.elapsed.inMilliseconds
                                  .toString()
                                  .substring(
                                      _stopwatch.elapsed.inMilliseconds
                                              .toString()
                                              .length -
                                          3,
                                      _stopwatch.elapsed.inMilliseconds
                                              .toString()
                                              .length -
                                          1)
                          : _stopwatch.elapsed.inMilliseconds
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    double _width = MediaQuery.of(context).size.width;
    double _btnWidth = (_width / 2) - 15 - 32;
    double _translateValue = _btnWidth / 2 + 15;
    Duration _duration = Duration(milliseconds: 65);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          AnimatedContainer(
            transform: Matrix4.translationValues(
              _stopwatchStatus == StopWatchStatus.initial
                  ? -_translateValue
                  : 0.0,
              0.0,
              0.0,
            ),
            duration: _duration,
            width: _btnWidth,
            child: FlatButton(
              onPressed: () {
                if (_stopwatchStatus == StopWatchStatus.running) {
                  /// TODO create LAP
                } else if (_stopwatchStatus == StopWatchStatus.paused) {
                  setState(() {
                    _stopwatchStatus = StopWatchStatus.initial;
                    _stopwatch.reset();
                    // _timer.cancel();
                  });
                }
              },
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Palette.tertiaryButton,
              textColor: Palette.primaryFont,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                (_stopwatchStatus == StopWatchStatus.initial)
                    ? ""
                    : (_stopwatchStatus == StopWatchStatus.paused)
                        ? "RESET"
                        : "LAP",
                style: GoogleFonts.getFont(
                  'Electrolize',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 30),
          AnimatedContainer(
            duration: _duration,
            width: _btnWidth,
            transform: Matrix4.translationValues(
              _stopwatchStatus == StopWatchStatus.initial
                  ? _translateValue
                  : 0.0,
              0.0,
              0.0,
            ),
            child: FlatButton(
              onPressed: () {
                if (_stopwatchStatus == StopWatchStatus.initial) {
                  setState(() {
                    _stopwatchStatus = StopWatchStatus.running;
                    _stopwatch.start();
                    _timer = Timer.periodic(_timerTick, setTime);
                  });
                } else if (_stopwatchStatus == StopWatchStatus.paused) {
                  setState(() {
                    _stopwatchStatus = StopWatchStatus.running;
                    _stopwatch.start();
                    _timer = Timer.periodic(_timerTick, setTime);
                  });
                } else {
                  setState(() {
                    _stopwatchStatus = StopWatchStatus.paused;
                    _stopwatch.stop();
                    // _timer.cancel();
                  });
                }
              },
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Palette.primaryButton,
              textColor: Palette.buttonFont,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                (_stopwatchStatus == StopWatchStatus.initial)
                    ? "START"
                    : (_stopwatchStatus == StopWatchStatus.paused)
                        ? "RESUME"
                        : "STOP",
                style: GoogleFonts.getFont(
                  'Electrolize',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

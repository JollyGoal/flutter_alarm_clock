import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/data.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

Stopwatch _stopwatchMain = Stopwatch();
StopwatchStatus _stopwatchStatus = StopwatchStatus.initial;

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({Key key}) : super(key: key);

  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  static const Duration _timerTick = const Duration(milliseconds: 10);
  Timer _timer;

  void setTime(Timer timer) {
    // print('tick');
    setState(() {});
  }

  Future<void> addLap() async {
    lapsList.add(
      Lap(
        id: lapsList.length,
        overallTime: _stopwatchMain.elapsed,
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    if (_stopwatchMain.isRunning && (_timer == null || !_timer.isActive)) {
      _timer = Timer.periodic(_timerTick, setTime);
    }
    super.initState();
  }

  @override
  void dispose() {
    try {
      _timer.cancel();
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackground,
      bottomNavigationBar: buildBottomBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: buildStopwatchFace(),
          ),
          SliverToBoxAdapter(
            child: lapsList.isNotEmpty ? buildLapsBloc() : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget buildLapsBloc() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 18.0,
      children: lapsList
          .map((worldTime) => Container(
                height: 120,
                width: 200,
                color: Colors.red,
              ))
          .toList(),
    );
  }

  Widget buildStopwatchFace() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 140),
      height: lapsList.isNotEmpty ? 100.0 : 180.0,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.end,
        children: [
          _stopwatchMain.elapsed.inHours != 0
              ? SizedBox(
                  width: 78,
                  child: Text(
                    _stopwatchMain.elapsed.inHours.toString().padLeft(2, "0") +
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
          _stopwatchMain.elapsed.inHours != 0
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
              (_stopwatchMain.elapsed.inMinutes -
                      (60 * _stopwatchMain.elapsed.inHours))
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
              (_stopwatchMain.elapsed.inSeconds -
                      (60 * _stopwatchMain.elapsed.inMinutes))
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
              _stopwatchMain.elapsed.inMilliseconds.toString().length > 2
                  ? _stopwatchMain.elapsed.inMilliseconds.toString().substring(
                      _stopwatchMain.elapsed.inMilliseconds.toString().length -
                          3,
                      _stopwatchMain.elapsed.inMilliseconds.toString().length -
                          1)
                  : _stopwatchMain.elapsed.inMilliseconds
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
              _stopwatchStatus == StopwatchStatus.initial
                  ? -_translateValue
                  : 0.0,
              0.0,
              0.0,
            ),
            duration: _duration,
            width: _btnWidth,
            child: FlatButton(
              onPressed: () {
                if (_stopwatchStatus == StopwatchStatus.running) {
                  addLap();
                } else if (_stopwatchStatus == StopwatchStatus.paused) {
                  setState(() {
                    _stopwatchStatus = StopwatchStatus.initial;
                    _stopwatchMain.reset();
                    lapsList = [];
                    _timer.cancel();
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
                (_stopwatchStatus == StopwatchStatus.paused) ? "RESET" : "LAP",
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
              _stopwatchStatus == StopwatchStatus.initial
                  ? _translateValue
                  : 0.0,
              0.0,
              0.0,
            ),
            child: FlatButton(
              onPressed: () {
                if (_stopwatchStatus == StopwatchStatus.initial ||
                    _stopwatchStatus == StopwatchStatus.paused) {
                  setState(() {
                    _stopwatchStatus = StopwatchStatus.running;
                    _stopwatchMain.start();
                    _timer = Timer.periodic(_timerTick, setTime);
                  });
                } else {
                  setState(() {
                    _stopwatchStatus = StopwatchStatus.paused;
                    _stopwatchMain.stop();
                    _timer.cancel();
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
                (_stopwatchStatus == StopwatchStatus.initial)
                    ? "START"
                    : (_stopwatchStatus == StopwatchStatus.paused)
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

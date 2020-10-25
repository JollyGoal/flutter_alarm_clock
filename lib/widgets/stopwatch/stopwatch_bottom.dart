import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/data.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class StopwatchBottom extends StatefulWidget {
  final Stopwatch stopwatchMain;
  final StreamController<StopwatchStatus> stopwatchStateController;
  final Function addLap;
  final Function clearLapsList;

  const StopwatchBottom({
    Key key,
    @required this.stopwatchMain,
    @required this.stopwatchStateController,
    @required this.addLap,
    @required this.clearLapsList,
  }) : super(key: key);

  @override
  _StopwatchBottomState createState() => _StopwatchBottomState();
}

class _StopwatchBottomState extends State<StopwatchBottom> {
  StreamSubscription _stopwatchSubscription;

  void handleStopwatchBottomUpdate(StopwatchStatus state) {
    setState(() {
      stopwatchStatus = state;
    });
  }

  @override
  void initState() {
    super.initState();
    _stopwatchSubscription = widget.stopwatchStateController.stream
        .listen((state) => handleStopwatchBottomUpdate(state));
  }

  Future<void> handleSecondaryBtnPress() async {
    if (stopwatchStatus == StopwatchStatus.running) {
      widget.addLap();
    } else if (stopwatchStatus == StopwatchStatus.paused) {
      widget.stopwatchMain.reset();
      widget.stopwatchStateController.add(StopwatchStatus.initial);
      widget.clearLapsList();
      setState(() {});
    }
  }

  Future<void> handlePrimaryBtnPress() async {
    if (stopwatchStatus == StopwatchStatus.initial ||
        stopwatchStatus == StopwatchStatus.paused) {
      setState(() {
        widget.stopwatchMain.start();
        widget.stopwatchStateController.add(StopwatchStatus.running);
      });
    } else {
      setState(() {
        widget.stopwatchMain.stop();
        widget.stopwatchStateController.add(StopwatchStatus.paused);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              stopwatchStatus == StopwatchStatus.initial
                  ? -_translateValue
                  : 0.0,
              0.0,
              0.0,
            ),
            duration: _duration,
            width: _btnWidth,
            child: FlatButton(
              onPressed: () {
                handleSecondaryBtnPress();
              },
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Palette.tertiaryButton,
              textColor: Palette.primaryFont,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                (stopwatchStatus == StopwatchStatus.paused) ? "RESET" : "LAP",
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
              stopwatchStatus == StopwatchStatus.initial
                  ? _translateValue
                  : 0.0,
              0.0,
              0.0,
            ),
            child: FlatButton(
              onPressed: () {
                handlePrimaryBtnPress();
              },
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Palette.primaryButton,
              textColor: Palette.buttonFont,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                (stopwatchStatus == StopwatchStatus.initial)
                    ? "START"
                    : (stopwatchStatus == StopwatchStatus.paused)
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

  @override
  void dispose() {
    _stopwatchSubscription.cancel();
    super.dispose();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/data.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerBottom extends StatefulWidget {
  final StreamController<TimerStatus> timerStateController;
  final Function(TimerAction) handleTimer;

  const TimerBottom({
    Key key,
    @required this.timerStateController,
    @required this.handleTimer,
  }) : super(key: key);

  @override
  _StopwatchBottomState createState() => _StopwatchBottomState();
}

class _StopwatchBottomState extends State<TimerBottom> {
  StreamSubscription _timerSubscription;

  @override
  void initState() {
    _timerSubscription = widget.timerStateController.stream.listen((state) {
      timerStatus = state;
      try {
        setState(() {});
      } catch (e) {}
    });
    super.initState();
  }

  Future<void> handleCancelBtnPress() async {
    widget.handleTimer(TimerAction.cancel);
    setState(() {});
  }

  Future<void> handlePrimaryBtnPress() async {
    if (timerStatus == TimerStatus.initial ||
        timerStatus == TimerStatus.paused) {
      setState(() {
        widget.handleTimer(TimerAction.run);
      });
    } else {
      setState(() {
        widget.handleTimer(TimerAction.pause);
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
              timerStatus == TimerStatus.initial ? -_translateValue : 0.0,
              0.0,
              0.0,
            ),
            duration: _duration,
            width: _btnWidth,
            child: FlatButton(
              onPressed: () {
                handleCancelBtnPress();
              },
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Palette.tertiaryButton,
              textColor: Palette.primaryFont,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                "CANCEL",
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
              timerStatus == TimerStatus.initial ? _translateValue : 0.0,
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
                (timerStatus == TimerStatus.initial)
                    ? "START"
                    : (timerStatus == TimerStatus.paused) ? "RESUME" : "PAUSE",
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
    if (timerStatus != TimerStatus.running) {
      _timerSubscription?.cancel();
    }
    super.dispose();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/data.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:flutter_alarm_clock/widgets/widgets.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen({Key key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer _timer;

  void timerPickerChanged(String event, int value) {
    switch (event) {
      case "hour":
        prefHour = value;
        break;
      case "min":
        prefMin = value;
        break;
      case "sec":
        prefSec = value;
        break;
    }
    countdownSeconds = getPrefInSeconds;
  }

  void handleTick(Timer timer) {
    countdownSeconds = countdownSeconds - 1;
    if (countdownSeconds.isNegative) {
      try {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Time's up")));
      } catch (e) {}
      handleTimer(TimerAction.cancel);
    }
  }

  Future<void> handleTimer(TimerAction action) async {
    switch (action) {
      case TimerAction.cancel:
        _timer?.cancel();
        countdownSeconds = getPrefInSeconds;
        timerState.add(TimerStatus.initial);
        break;
      case TimerAction.run:
        if (countdownSeconds == 0) {
          countdownSeconds = getPrefInSeconds;
          if (countdownSeconds == 0) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Set the timer first!")));
            break;
          }
        }
        _timer = Timer.periodic(Duration(seconds: 1), handleTick);
        timerState.add(TimerStatus.running);
        break;
      case TimerAction.pause:
        _timer?.cancel();
        timerState.add(TimerStatus.paused);
        break;
    }
    try {
      setState(() {});
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackground,
      bottomNavigationBar: TimerBottom(
        timerStateController: timerState,
        handleTimer: (action) => handleTimer(action),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: const SizedBox(height: 50),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: Stack(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 160),
                    curve: Curves.linear,
                    opacity: timerStatus == TimerStatus.initial ? 0 : 1,
                    child: TimerCountdown(
                      timerStateController: timerState,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 160),
                      opacity: timerStatus == TimerStatus.initial ? 1 : 0,
                      curve: Curves.linear,
                      child: TimerPicker(
                        active: timerStatus == TimerStatus.initial,
                        hour: prefHour,
                        minute: prefMin,
                        second: prefSec,
                        valChanged: (String units, int index) =>
                            timerPickerChanged(units, index),
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
}

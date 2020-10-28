import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/data.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';

import '../widgets.dart';

const PI = 3.14;

class TimerCountdown extends StatefulWidget {
  final StreamController<TimerStatus> timerStateController;

  const TimerCountdown({
    Key key,
    @required this.timerStateController,
  }) : super(key: key);

  @override
  _TimerCountdownState createState() => _TimerCountdownState();
}

class _TimerCountdownState extends State<TimerCountdown> {
  Timer _timer;
  StreamSubscription _timerSubscription;

  void handleCountdownUpdate(TimerStatus status) {
    switch (status) {
      case TimerStatus.initial:
        _timer?.cancel();
        break;
      case TimerStatus.paused:
        _timer?.cancel();
        break;
      case TimerStatus.running:
        _timer = Timer.periodic(Duration(milliseconds: 100), (_) {
          try {
            setState(() {});
          } catch (e) {}
        });
        break;
    }
  }

  @override
  void initState() {
    _timerSubscription = widget.timerStateController.stream
        .listen((status) => handleCountdownUpdate(status));
    super.initState();
    handleCountdownUpdate(timerStatus);
  }

  @override
  Widget build(BuildContext context) {
    final Duration elapsed = Duration(seconds: getCountdownSeconds);
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: ShaderMask(
              shaderCallback: (rect) {
                // final double value = getCountdownSeconds != getPrefInSeconds
                //     ? getCountdownSeconds / getPrefInSeconds
                //     : 0;
                final double value = getCountdownSeconds / getPrefInSeconds;
                return SweepGradient(
                    startAngle: 0.0,
                    endAngle: 2 * PI,
                    stops: [value, value],
                    center: Alignment.center,
                    colors: [
                      Palette.primaryButton,
                      Palette.secondaryButton
                    ]).createShader(rect);
              },
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: Image.asset("assets/radial_scale.png").image)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 70,
                child: TimerPickerElem(
                    label: elapsed.inHours.toString().padLeft(2, "0")),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: TimerPickerElem(label: ":"),
              ),
              SizedBox(
                width: 70,
                child: TimerPickerElem(
                    label: (elapsed.inMinutes - (60 * elapsed.inHours))
                        .toString()
                        .padLeft(2, "0")),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: TimerPickerElem(label: ":"),
              ),
              SizedBox(
                width: 70,
                child: TimerPickerElem(
                    label: (elapsed.inSeconds - (60 * elapsed.inMinutes))
                        .toString()
                        .padLeft(2, "0")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timerSubscription?.cancel();
    super.dispose();
  }
}

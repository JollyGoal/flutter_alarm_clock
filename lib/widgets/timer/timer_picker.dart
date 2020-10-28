import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_alarm_clock/widgets/widgets.dart';

class TimerPicker extends StatefulWidget {
  final bool active;
  final int hour;
  final int minute;
  final int second;
  final Function valChanged;

  const TimerPicker({
    Key key,
    this.active = true,
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
    @required this.valChanged,
  }) : super(key: key);

  @override
  _TimerPickerState createState() => _TimerPickerState();
}

class _TimerPickerState extends State<TimerPicker> {
  FixedExtentScrollController _hourController;
  FixedExtentScrollController _minController;
  FixedExtentScrollController _secController;
  List<String> hours = [];
  List<String> minSec = [];

  @override
  void initState() {
    for (var i = 0; i <= 99; i++) {
      hours.add(i.toString().padLeft(2, "0"));
    }
    for (var i = 0; i <= 60; i++) {
      minSec.add(i.toString().padLeft(2, "0"));
    }
    _hourController = FixedExtentScrollController(initialItem: widget.hour);
    _minController = FixedExtentScrollController(initialItem: widget.minute);
    _secController = FixedExtentScrollController(initialItem: widget.second);
    super.initState();

    /// Following [SchedulerBinding] is a simple crutch
    /// it is used because [FixedExtentScrollController]
    /// does not set [initialItem] properly, possibly a flutter bug.
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _hourController.jumpToItem(widget.hour);
      _minController.jumpToItem(widget.minute);
      _secController.jumpToItem(widget.second);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.active,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            child: ListWheelScrollView(
              controller: _hourController,
              onSelectedItemChanged: (index) => widget.valChanged("hour", index),
              physics: FixedExtentScrollPhysics(),
              diameterRatio: 1.5,
              overAndUnderCenterOpacity: 0.6,
              perspective: 0.005,
              itemExtent: 90,
              children: hours.map((e) => TimerPickerElem(label: e)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 55),
            child: TimerPickerElem(label: ":"),
          ),
          SizedBox(
            width: 70,
            child: ListWheelScrollView(
              controller: _minController,
              onSelectedItemChanged: (index) => widget.valChanged("min", index),
              physics: FixedExtentScrollPhysics(),
              diameterRatio: 1.5,
              overAndUnderCenterOpacity: 0.6,
              perspective: 0.005,
              itemExtent: 90,
              children: minSec.map((e) => TimerPickerElem(label: e)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 55),
            child: TimerPickerElem(label: ":"),
          ),
          SizedBox(
            width: 70,
            child: ListWheelScrollView(
              controller: _secController,
              onSelectedItemChanged: (index) => widget.valChanged("sec", index),
              physics: FixedExtentScrollPhysics(),
              diameterRatio: 1.5,
              overAndUnderCenterOpacity: 0.6,
              perspective: 0.005,
              itemExtent: 90,
              children: minSec.map((e) => TimerPickerElem(label: e)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

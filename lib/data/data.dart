import 'dart:async';

import 'models/models.dart';

List<WorldTime> worldTimeList = [
  WorldTime(
      location: "Atlantic/Azores", utcOffset: UtcOffset(sign: "+", hours: 0)),
  WorldTime(
      location: "Asia/Tashkent", utcOffset: UtcOffset(sign: "+", hours: 5)),
  WorldTime(
      location: "Europe/London",
      utcOffset: UtcOffset(sign: "-", hours: 1, minutes: 30)),
  WorldTime(location: "GGGGGG", utcOffset: UtcOffset(sign: "+", hours: 1)),
  WorldTime(
      location: "Europe/Berlin", utcOffset: UtcOffset(sign: "-", hours: 2)),
];

List<Alarm> alarmsList = [
  Alarm(
      isEnabled: true,
      time: "12:20",
      daysOfWeek: [DateTime.monday, DateTime.sunday]),
  Alarm(isEnabled: true, time: "22:20", daysOfWeek: [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
    DateTime.thursday,
    DateTime.wednesday
  ]),
  Alarm(isEnabled: false, time: "16:45"),
  Alarm(isEnabled: true, time: "00:00", daysOfWeek: [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.friday,
    DateTime.saturday
  ]),
  Alarm(isEnabled: false, time: "4:30", daysOfWeek: [DateTime.friday]),
  Alarm(isEnabled: true, time: "11:30"),
];

List<Lap> lapsList = [];

StreamController<StopwatchStatus> stopwatchState = StreamController<StopwatchStatus>.broadcast();

StopwatchStatus stopwatchStatus = StopwatchStatus.initial;

Stopwatch stopwatchMain = Stopwatch();
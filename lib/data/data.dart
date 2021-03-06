import 'dart:async';

import 'models/models.dart';

List<WorldTime> worldTimeList = [
  WorldTime(
      location: "Atlantic/Azores", utcOffset: UtcOffset(sign: "-", hours: 1)),
  WorldTime(
      location: "Asia/Tashkent", utcOffset: UtcOffset(sign: "+", hours: 5)),
  WorldTime(
      location: "Europe/London",
      utcOffset: UtcOffset(sign: "+", hours: 0, minutes: 0)),
  WorldTime(location: "Tokyo", utcOffset: UtcOffset(sign: "+", hours: 9)),
  WorldTime(
      location: "Europe/Berlin", utcOffset: UtcOffset(sign: "+", hours: 1)),
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

/// Stopwatch
List<Lap> lapsList = [];

StreamController<StopwatchStatus> stopwatchState =
    StreamController<StopwatchStatus>.broadcast();

StopwatchStatus stopwatchStatus = StopwatchStatus.initial;

Stopwatch stopwatchMain = Stopwatch();

/// Timer

StreamController<TimerStatus> timerState =
    StreamController<TimerStatus>.broadcast();

TimerStatus timerStatus = TimerStatus.initial;

int countdownSeconds = 0;

int get getCountdownSeconds => countdownSeconds;

/// TODO Following preferred values should be saved in shared_preferences
int prefHour = 0;
int prefMin = 0;
int prefSec = 0;

int get getPrefInSeconds =>
    Duration(hours: prefHour, minutes: prefMin, seconds: prefSec).inSeconds;

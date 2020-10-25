import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/data.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:flutter_alarm_clock/widgets/widgets.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({Key key}) : super(key: key);

  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);

  Future<void> addLap() async {
    lapsList.add(
      Lap(
        id: lapsList.length,
        overallTime: stopwatchMain.elapsed,
      ),
    );
    setState(() {});
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    });
  }

  Future<void> removeLap(int index) async {
    lapsList.removeAt(index);
    setState(() {});
  }

  Future<void> clearLapsList() async {
    lapsList = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackground,
      bottomNavigationBar: StopwatchBottom(
        stopwatchMain: stopwatchMain,
        stopwatchStateController: stopwatchState,
        addLap: () => addLap(),
        clearLapsList: () => clearLapsList(),
      ),
      body: Column(
        children: [
          AnimatedContainer(
            width: double.infinity,
            duration: const Duration(milliseconds: 140),
            height: lapsList.isNotEmpty ? 100.0 : 180.0,
            child: StopwatchFace(
              stopwatchMain: stopwatchMain,
              stopwatchStateController: stopwatchState,
            ),
          ),
          lapsList.isNotEmpty ? buildLapsBloc() : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget buildLapsBloc() {
    final double _height = MediaQuery.of(context).size.height - 50 - 201;
    return Container(
      height: _height - (lapsList.length >= 2 ? 100 : 180),
      width: double.infinity,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          runSpacing: 18.0,
          children: lapsList.asMap().entries
              .map((entry) => LapCard(
                    lap: entry.value,
                    removeLap: () => removeLap(entry.key),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

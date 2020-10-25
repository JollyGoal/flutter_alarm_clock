import 'dart:async';

import 'package:flutter/material.dart';
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
  Future<void> addLap() async {
    lapsList.add(
      Lap(
        id: lapsList.length,
        overallTime: stopwatchMain.elapsed,
      ),
    );
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 140),
              height: lapsList.isNotEmpty ? 100.0 : 180.0,
              child: StopwatchFace(
                stopwatchMain: stopwatchMain,
                stopwatchStateController: stopwatchState,
              ),
            ),
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
          .map((lap) => Container(
                height: 120,
                width: 200,
                color: Colors.red,
              ))
          .toList(),
    );
  }
}

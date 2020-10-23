import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class WorldTimeCard extends StatefulWidget {
  final WorldTime worldTime;
  final double height;
  final Duration updateDuration;

  const WorldTimeCard({
    Key key,
    @required this.worldTime,
    this.height = 120,
    this.updateDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _WorldTimeCardState createState() => _WorldTimeCardState();
}

class _WorldTimeCardState extends State<WorldTimeCard> {
  Timer _timer;
  DateTime _dateTime;
  String _digits;
  String _offsetString;

  @override
  void initState() {
    _offsetString =
        "UTC ${widget.worldTime.utcOffset.sign}${widget.worldTime.utcOffset.hours.toString().padLeft(2, '0')}:${widget.worldTime.utcOffset.minutes.toString().padLeft(2, '0')}";

    _dateTime = DateTime.now().toUtc();
    widget.worldTime.utcOffset.sign == "+"
        ? _dateTime = _dateTime.add(Duration(
            hours: widget.worldTime.utcOffset.hours,
            minutes: widget.worldTime.utcOffset.minutes))
        : _dateTime = _dateTime.subtract(Duration(
            hours: widget.worldTime.utcOffset.hours,
            minutes: widget.worldTime.utcOffset.minutes));

    _digits =
        '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}';

    super.initState();
    this._timer = Timer.periodic(widget.updateDuration, setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      _dateTime = DateTime.now().toUtc();
      widget.worldTime.utcOffset.sign == "+"
          ? _dateTime = _dateTime.add(Duration(
              hours: widget.worldTime.utcOffset.hours,
              minutes: widget.worldTime.utcOffset.minutes))
          : _dateTime = _dateTime.subtract(Duration(
              hours: widget.worldTime.utcOffset.hours,
              minutes: widget.worldTime.utcOffset.minutes));
      _digits =
          '${_dateTime.hour.toString().padLeft(2, '0')}:${_dateTime.minute.toString().padLeft(2, '0')}';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: widget.height,
          width: double.infinity,
          child: Material(
            color: Palette.cardBackground,
            borderRadius: BorderRadius.circular(30.0),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.worldTime.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.getFont(
                              'Electrolize',
                              textStyle: const TextStyle(
                                fontSize: 20,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            _offsetString,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.getFont(
                              'Electrolize',
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _digits,
                      style: GoogleFonts.getFont(
                        'Electrolize',
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

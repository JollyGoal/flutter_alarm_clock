import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmCard extends StatefulWidget {
  final Alarm alarm;
  final double height;
  final Duration updateDuration;

  const AlarmCard({
    Key key,
    @required this.alarm,
    this.height = 120,
    this.updateDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _AlarmCardState createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  final List<int> _allDays = [1, 2, 3, 4, 5, 6, 7];
  String _daysOfWeek;

  String defineDays(int index) {
    switch (index) {
      case 1:
        {
          return "M";
        }
        break;
      case 2:
        {
          return "T";
        }
        break;
      case 3:
        {
          return "W";
        }
        break;
      case 4:
        {
          return "T";
        }
        break;
      case 5:
        {
          return "F";
        }
        break;
      case 6:
        {
          return "S";
        }
        break;
      case 7:
        {
          return "S";
        }
        break;
      default:
        {
          return "";
        }
    }
  }

  @override
  void initState() {
    if (widget.alarm.daysOfWeek != null && widget.alarm.daysOfWeek.length > 0) {

    } else {
      widget.alarm.isEnabled = false;
    }
    super.initState();
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
          color: Palette.cardBackground,
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
                        widget.alarm.time,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.getFont(
                          'Electrolize',
                          textStyle: TextStyle(
                            fontSize: 25,
                            color: widget.alarm.isEnabled
                                ? Palette.primaryFont
                                : Palette.tertiaryFont,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: GoogleFonts.getFont(
                            'Electrolize',
                            textStyle: TextStyle(
                              color: widget.alarm.isEnabled
                                  ? Palette.primaryFont
                                  : Palette.tertiaryFont,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: buildDaysOfWeek(),
                        ),
                      )
                    ],
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    activeColor: Palette.primaryButton,
                    trackColor: Palette.secondaryButton,
                    value: widget.alarm.isEnabled,
                    onChanged: (val) {
                      if (widget.alarm.daysOfWeek != null &&
                          widget.alarm.daysOfWeek.isNotEmpty) {
                        setState(() {
                          widget.alarm.isEnabled = val;
                        });
                      } else {
                        /// TODO here should be method to set week days
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> buildDaysOfWeek() {
    List<TextSpan> _outList = [];
    if (widget.alarm.daysOfWeek != null && widget.alarm.daysOfWeek.length > 0) {
      if (widget.alarm.daysOfWeek.length == 7) {
        _outList.add(TextSpan(text: "Every day"));
        return _outList;
      }
      _allDays.forEach((element) {
        if (widget.alarm.daysOfWeek.contains(element)) {
          _outList.add(TextSpan(text: "${defineDays(element)}  "));
        } else {
          _outList.add(TextSpan(
            text: "${defineDays(element)}  ",
            style: const TextStyle(
              color: Palette.secondaryFont,
            ),
          ));
        }
      });
    } else {
      _outList.add(TextSpan(text: "Days are not set"));
    }
    return _outList;
  }
}

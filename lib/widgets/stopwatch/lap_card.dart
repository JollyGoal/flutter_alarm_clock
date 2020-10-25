import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class LapCard extends StatelessWidget {
  final Lap lap;
  final Function removeLap;

  const LapCard({
    Key key,
    @required this.lap,
    @required this.removeLap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _digits = lap.overallTime.inHours != 0
        ? lap.overallTime.inHours.toString().padLeft(2, "0") + ":"
        : "";
    _digits = _digits +
        (lap.overallTime.inMinutes - (60 * lap.overallTime.inHours))
            .toString()
            .padLeft(2, "0") +
        ":";
    _digits = _digits +
        (lap.overallTime.inSeconds - (60 * lap.overallTime.inMinutes))
            .toString()
            .padLeft(2, "0") +
        ".";
    _digits = _digits +
        (lap.overallTime.inMilliseconds.toString().length > 2
            ? lap.overallTime.inMilliseconds.toString().substring(
                lap.overallTime.inMilliseconds.toString().length - 3,
                lap.overallTime.inMilliseconds.toString().length - 1)
            : lap.overallTime.inMilliseconds.toString().padLeft(2, "0"));
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 120,
        width: 180,
        color: Palette.cardBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: removeLap,
                child: Icon(
                  Icons.delete_forever,
                  color: Palette.secondaryButton,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "LAP ${lap.id + 1}",
              style: GoogleFonts.getFont(
                'Electrolize',
                textStyle: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "$_digits",
              style: GoogleFonts.getFont(
                'Electrolize',
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

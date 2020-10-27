import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerPickerElem extends StatelessWidget {
  final String label;

  const TimerPickerElem({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: GoogleFonts.getFont(
        'Electrolize',
        textStyle: TextStyle(
          fontSize: 35,
          color: Palette.primaryFont,
          letterSpacing: 4,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}


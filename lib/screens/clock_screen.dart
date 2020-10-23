import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/data.dart';
import 'package:flutter_alarm_clock/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key key}) : super(key: key);

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(32.0),
            sliver: SliverToBoxAdapter(
              child: Clock(
                circleColor: Palette.cardBackground,
                shadowColor: Palette.scaffoldBackground,
                clockDialColor: Palette.clockDialBackground,
                showDigits: true,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: worldTimeList
                    .map((worldTime) => WorldTimeCard(
                          worldTime: worldTime,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomBar(),
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FlatButton(
              onPressed: () => print('ADD'),
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Palette.primaryButton,
              textColor: Palette.buttonFont,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                "ADD",
                style: GoogleFonts.getFont(
                  'Electrolize',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: FlatButton(
              onPressed: () => print('EDIT'),
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Palette.tertiaryButton,
              textColor: Palette.primaryFont,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                "EDIT",
                style: GoogleFonts.getFont(
                  'Electrolize',
                  textStyle: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

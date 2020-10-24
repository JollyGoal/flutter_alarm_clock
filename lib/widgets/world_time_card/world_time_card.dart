import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/config/palette.dart';
import 'package:flutter_alarm_clock/data/models/models.dart';
import 'package:flutter_alarm_clock/widgets/world_time_card/world_time_clock_face.dart';
import 'package:google_fonts/google_fonts.dart';

class WorldTimeCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    String _offsetString =
        "UTC ${worldTime.utcOffset.sign}${worldTime.utcOffset.hours.toString().padLeft(2, '0')}:${worldTime.utcOffset.minutes.toString().padLeft(2, '0')}";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: height,
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
                            worldTime.name,
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
                    WorldTimeClockFace(utcOffset: worldTime.utcOffset),
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

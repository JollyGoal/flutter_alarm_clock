import 'package:flutter/material.dart';

class ClockFace extends StatelessWidget {
  final Color circleColor;
  final Color shadowColor;
  final Color clockDialColor;

  const ClockFace({
    Key key,
    @required this.circleColor,
    @required this.shadowColor,
    @required this.clockDialColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: clockDialColor,
            ),
          ),
          AspectRatio(
            aspectRatio: 0.85,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    spreadRadius: -4,
                    color: shadowColor,
                  )
                ],
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 0.65,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    spreadRadius: -4,
                    color: shadowColor,
                  )
                ],
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 0.40,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    spreadRadius: -4,
                    color: shadowColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

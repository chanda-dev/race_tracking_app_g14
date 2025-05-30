import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/providers/stop_watch_provider.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class TimeCount extends StatelessWidget {
  final Duration duration;
  final double fontSize;
  final FontWeight fontWeight;
  const TimeCount({
    super.key,
    required this.fontSize,
    required this.fontWeight,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(
      duration.inMinutes.remainder(60),
    );
    final seconds = twoDigits(
      duration.inSeconds.remainder(60),
    );
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTimeCard(
                time: hours,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              Text(
                ':',
                style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
              ),
              buildTimeCard(
                time: minutes,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              Text(
                ':',
                style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
              ),
              buildTimeCard(
                time: seconds,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTimeCard({
    required String time,
    required double fontSize,
    required FontWeight fontWeight,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),
            ),
          ),
        ],
      );
}

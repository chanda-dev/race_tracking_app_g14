import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/providers/stop_watch_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/tracker/widget/segment_back_button.dart';
import 'package:race_tracking_app_g14/UI/screens/tracker/widget/tracking_table.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/UI/widgets/time_count.dart';

class TimeTracking extends StatelessWidget {
  final Segment segment;
  const TimeTracking({super.key, required this.segment});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final stopWatchProvider = Provider.of<StopWatchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backGroundColor,
        elevation: 1.0,
        shadowColor: AppColors.thirdColor,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'RACE TRACKING ',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: AppTextStyles.heading.fontSize,
                  fontWeight: AppTextStyles.heading.fontWeight,
                ),
              ),
              Text(
                'APP',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: AppTextStyles.heading.fontSize,
                  fontWeight: AppTextStyles.heading.fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: AppColors.backGroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.primary,
                        size: AppTextStyles.title.fontSize,
                      ),
                      label: Text(
                        segment.name,
                        style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: AppTextStyles.title.fontSize),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: TimeCount(
                  fontSize: AppTextStyles.watch.fontSize!,
                  fontWeight: AppTextStyles.watch.fontWeight!,
                  duration: stopWatchProvider.duration,
                ),
              ),
              Expanded(
                child: TrackingTable(
                  participantProvider: participantProvider,
                  segment: segment,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

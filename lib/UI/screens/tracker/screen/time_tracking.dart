import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/tracker/widget/segment_back_button.dart';
import 'package:race_tracking_app_g14/UI/screens/tracker/widget/tracking_table.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/UI/widgets/time_count.dart';

class TimeTracking extends StatelessWidget {
  const TimeTracking({super.key});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    return Container(
      color: AppColors.backGroundColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SegmentBackButton(text: 'Swimming'),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: TimeCount(
                  fontSize: AppTextStyles.watch.fontSize!,
                  fontWeight: AppTextStyles.watch.fontWeight!,
                  duration: Duration(hours: 0, minutes: 0, seconds: 0)),
            ),
            Expanded(
                child: TrackingTable(
              participantProvider: participantProvider,
            ))
          ],
        ),
      ),
    );
  }
}

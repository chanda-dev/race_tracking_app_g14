import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/widget/result_table.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/widget/time_count.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class StartRace extends StatelessWidget {
  const StartRace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Count',
              style: TextStyle(
                fontSize: AppTextStyles.heading.fontSize,
                fontWeight: AppTextStyles.heading.fontWeight,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: TimeCount(
                fontSize: AppTextStyles.watch.fontSize!,
                fontWeight: AppTextStyles.watch.fontWeight!,
              ),
            )
          ],
        ),
      ),
    );
  }
}

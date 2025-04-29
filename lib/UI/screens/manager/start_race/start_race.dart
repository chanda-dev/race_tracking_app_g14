import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/stop_watch_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/widget/time_count.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/UI/widgets/action/race_button.dart';

class StartRace extends StatelessWidget {
  const StartRace({super.key});

  @override
  Widget build(BuildContext context) {
    final stopWatchProvider = Provider.of<StopWatchProvider>(context);
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
                stopWatchProvider: stopWatchProvider,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaceButton(
                  text: 'Reset',
                  color: AppColors.thirdColor,
                  onClick: stopWatchProvider.resetTimer,
                ),
                const SizedBox(width: 20),
                stopWatchProvider.isStart
                    ? RaceButton(
                      text: 'Start',
                      color: AppColors.green,
                      onClick: stopWatchProvider.startTimer,
                    )
                    : RaceButton(
                      text: 'Stop',
                      color: AppColors.green,
                      onClick: stopWatchProvider.stopTimer,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/stop_watch_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/widget/result_table.dart';
import 'package:race_tracking_app_g14/UI/widgets/time_count.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
                duration: stopWatchProvider.duration,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaceButton(
                  width: 120,
                  height: 50,
                  text: 'Reset',
                  color: AppColors.thirdColor,
                  onClick: stopWatchProvider.resetTimer,
                  textColor: AppColors.secondaryColor,
                  fontSize: 18,
                ),
                const SizedBox(width: 20),
                stopWatchProvider.isStart
                    ? RaceButton(
                        width: 120,
                        height: 50,
                        text: 'Start',
                        color: AppColors.green,
                        onClick: () => stopWatchProvider.startTimer(context),
                        textColor: AppColors.secondaryColor,
                        fontSize: 18,
                      )
                    : RaceButton(
                        width: 120,
                        height: 50,
                        text: 'Stop',
                        color: Colors.red,
                        onClick: stopWatchProvider.stopTimer,
                        textColor: AppColors.secondaryColor,
                        fontSize: 18,
                      ),
              ],
            ),
            Expanded(child: ResultTable()),
            Column(
              children: [
                RaceButton(
                  height: 27,
                  width: 104,
                  text: 'See all',
                  color: AppColors.primary,
                  onClick: () {},
                  textColor: AppColors.white,
                  fontSize: 18,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

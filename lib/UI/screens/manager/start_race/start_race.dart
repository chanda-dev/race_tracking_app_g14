import 'package:flutter/material.dart';
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
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 50,
                  color: Colors.grey[200], // <-- No border radius = Square
                  child: TextButton(
                    onPressed: () {
                      // tuk ter implementasi
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        // <-- Make it square
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 120,
                  height: 50,
                  color: Colors.green, // <-- No border radius = Square
                  child: TextButton(
                    onPressed: () {
                      //jam ter implementasi
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // <-- Make it square
                      ),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

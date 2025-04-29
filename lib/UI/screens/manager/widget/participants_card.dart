import 'package:flutter/material.dart';
import '../../../../models/participant/participant_model.dart';
import '../../../theme/theme.dart';

class ParticipateCart extends StatelessWidget {
  final Participant participant;
  final bool isClick;
  final VoidCallback onCartPress;
  const ParticipateCart({
    super.key,
    required this.participant,
    required this.isClick,
    required this.onCartPress,
  });

  @override
  Widget build(BuildContext context) {
    if (isClick == false) {
      String overallTime;
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        onPressed: onCartPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              participant.bibNumber,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: AppTextStyles.body.fontWeight,
                backgroundColor: AppColors.thirdColor,
              ),
            ),
            Text(
              '${participant.firstName} ${participant.lastName}',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: AppTextStyles.body.fontWeight,
              ),
            ),
            Text(
              participant.age.toString(),
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: AppTextStyles.body.fontWeight,
              ),
            ),
            Text(
              overallTime = (participant.runningTime +
                      participant.cyclingTime +
                      participant.swimmingTime)
                  .toString(),
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: AppTextStyles.body.fontWeight,
              ),
            ),
          ],
        ),
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: onCartPress,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                participant.bibNumber,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: AppTextStyles.body.fontWeight,
                ),
              ),
              Text(
                '${participant.firstName} ${participant.lastName}',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: AppTextStyles.body.fontWeight,
                ),
              ),
              Text(
                participant.age.toString(),
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: AppTextStyles.body.fontWeight,
                ),
              ),
            ],
          ),
          Container(color: AppColors.secondaryColor, height: 1),
          Container(
            color: AppColors.thirdColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
        ],
      ),
    );
  }
}

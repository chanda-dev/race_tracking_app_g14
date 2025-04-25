import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

class ParticipateCart extends StatelessWidget {
  final Participant participant;
  final bool isClick;
  final VoidCallback onCartPress;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const ParticipateCart({
    super.key,
    required this.participant,
    required this.isClick,
    required this.onCartPress,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (isClick == false) {
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
                  color: AppColors.secondaryColor,
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

              children: [
                ElevatedButton(
                  onPressed: onDelete,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

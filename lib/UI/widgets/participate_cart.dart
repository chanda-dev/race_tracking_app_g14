import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class ParticipateCart extends StatelessWidget {
  final String bibNumber;
  final String firstName;
  final String lastName;
  final String age;
  final bool isClick;
  final VoidCallback onCartPress;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final String id;
  const ParticipateCart({
    super.key,
    required this.bibNumber,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.isClick,
    required this.onCartPress,
    required this.onDelete,
    required this.onEdit,
    required this.id,
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
              bibNumber,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: AppTextStyles.body.fontWeight,
                backgroundColor: AppColors.thirdColor,
              ),
            ),
            Text(
              '$firstName $lastName',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: AppTextStyles.body.fontWeight,
              ),
            ),
            Text(
              age,
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
        backgroundColor: AppColors.thirdColor,
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
                bibNumber,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: AppTextStyles.body.fontWeight,
                ),
              ),
              Text(
                '$firstName $lastName',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: AppTextStyles.body.fontWeight,
                ),
              ),
              Text(
                age,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: AppTextStyles.body.fontWeight,
                ),
              ),
            ],
          ),
          Container(color: AppColors.secondaryColor, height: 1),
          Row(
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
        ],
      ),
    );
  }
}

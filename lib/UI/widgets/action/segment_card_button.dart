import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class SegmentCardButton extends StatelessWidget {
  final String segment;
  final String amount;
  final Icon icon;
  final VoidCallback onClick;

  const SegmentCardButton({
    super.key,
    required this.onClick,
    required this.icon,
    required this.segment,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacings.radius),
        border: Border.all(color: Colors.black, width: 1),
      ),
      alignment: Alignment.centerLeft,
      width: 396,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.zero,
          iconColor: AppColors.primary,
          foregroundColor: AppColors.secondaryColor,
          backgroundColor: AppColors.backGroundColor,
        ),
        onPressed: onClick,
        icon: Container(
          height: 87,
          width: 101,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacings.radius),
            border: Border(
              right: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          child: Icon(
            icon.icon,
            size: 50,
          ),
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                segment,
                style: TextStyle(
                    fontSize: AppTextStyles.heading.fontSize,
                    fontWeight: AppTextStyles.heading.fontWeight),
              ),
              Text(
                amount,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

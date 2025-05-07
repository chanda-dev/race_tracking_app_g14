import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class SegmentBackButton extends StatelessWidget {
  final String text;
  const SegmentBackButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_sharp,
              color: AppColors.secondaryColor,
              size: AppTextStyles.heading.fontSize,
            ),
            label: Text(
              text,
              style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: AppTextStyles.heading.fontSize),
            ))
      ],
    );
  }
}

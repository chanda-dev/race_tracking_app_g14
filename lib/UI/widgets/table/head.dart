import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class Head extends StatelessWidget {
  final String? first;
  final String? second;
  final String? third;
  final String? fourth;
  const Head({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(first!, style: TextStyle(color: AppColors.white)),
          Text(
            second!,
            style: TextStyle(color: AppColors.white),
          ),
          Text(
            third!,
            style: TextStyle(color: AppColors.white),
          ),
          Text(fourth!, style: TextStyle(color: AppColors.white)),
        ],
      ),
    );
  }
}

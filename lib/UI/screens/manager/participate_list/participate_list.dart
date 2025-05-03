import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/UI/widgets/part_table.dart';

class ParticipateList extends StatelessWidget {
  const ParticipateList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGroundColor,
      child: Column(
        children: [
          Expanded(child: const PartTable()),
        ],
      ),
    );
    ;
  }
}

import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/widgets/part_table.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class ParticipantsBody extends StatelessWidget {
  const ParticipantsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Segments Cover Box
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.thirdColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Segments Cover',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ),
          ),

          // Table of participants
          Expanded(child: PartTable()),
        ],
      ),
    );
  }
}

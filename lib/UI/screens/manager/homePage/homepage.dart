import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/widget/participants_body.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/UI/widgets/action/segment_card_button.dart';

class Homepage extends StatelessWidget {
  final String amount;
  final Function(Segment) onClick;

  const Homepage({super.key, required this.amount, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Segments Cover Box
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.thirdColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SegmentCardButton(
                          onClick: () => onClick(Segment.running),
                          icon: Icon(Segment.running.icon),
                          segment: Segment.running.name,
                          amount: '$amount participants'),
                      SegmentCardButton(
                          onClick: () => onClick(Segment.swimming),
                          icon: Icon(Segment.swimming.icon),
                          segment: Segment.swimming.name,
                          amount: '$amount participants'),
                      SegmentCardButton(
                          onClick: () => onClick(Segment.cycling),
                          icon: Icon(Segment.cycling.icon),
                          segment: Segment.cycling.name,
                          amount: '$amount participants'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Table of participants
          ParticipantsBody(),
        ],
      ),
    );
  }
}

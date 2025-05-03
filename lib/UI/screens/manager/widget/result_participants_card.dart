import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/drop_down_provider.dart';
import 'package:race_tracking_app_g14/utils/date_time_util.dart';
import '../../../../models/participant/participant_model.dart';
import '../../../theme/theme.dart';

class ResultParticipantsCard extends StatelessWidget {
  final Participant participant;
  const ResultParticipantsCard({
    super.key,
    required this.participant,
  });

  @override
  Widget build(BuildContext context) {
    final overallDuration = (participant.runningTime +
        participant.cyclingTime +
        participant.swimmingTime);
    final overallTime = DateTimeUtils.formatDuration(overallDuration);
    final swimmingTime = DateTimeUtils.formatDuration(participant.swimmingTime);
    final runningTime = DateTimeUtils.formatDuration(participant.runningTime);
    final cyclingTime = DateTimeUtils.formatDuration(participant.cyclingTime);
    final dropDownProvider = Provider.of<DropDownProvider>(context);
    final isExpanded = dropDownProvider.activeCardId == participant.id;
    if (isExpanded == false) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        onPressed: () => dropDownProvider.toggleCard(participant.id),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              participant.rank,
              style: TextStyle(
                color: participant.rank == '1'
                    ? AppColors.green
                    : (participant.rank == '2'
                        ? AppColors.orange
                        : (participant.rank == '3'
                            ? AppColors.primary
                            : AppColors.secondaryColor)),
                fontWeight: AppTextStyles.body.fontWeight,
                // backgroundColor: AppColors.thirdColor,
              ),
            ),
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
              overallTime,
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
      onPressed: () => dropDownProvider.toggleCard(participant.id),
      child: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          //   color: AppColors.backGroundColor,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         participant.rank,
          //         style: TextStyle(
          //           color: participant.rank == '1'
          //               ? AppColors.green
          //               : (participant.rank == '2'
          //                   ? AppColors.orange
          //                   : (participant.rank == '3'
          //                       ? AppColors.primary
          //                       : AppColors.secondaryColor)),
          //           fontWeight: AppTextStyles.body.fontWeight,
          //           // backgroundColor: AppColors.thirdColor,
          //         ),
          //       ),
          //       Text(
          //         participant.bibNumber,
          //         style: TextStyle(
          //           color: AppColors.secondaryColor,
          //           fontWeight: AppTextStyles.body.fontWeight,
          //         ),
          //       ),
          //       Text(
          //         '${participant.firstName} ${participant.lastName}',
          //         style: TextStyle(
          //           color: AppColors.secondaryColor,
          //           fontWeight: AppTextStyles.body.fontWeight,
          //         ),
          //       ),
          //       Text(
          //         overallTime,
          //         style: TextStyle(
          //           color: AppColors.secondaryColor,
          //           fontWeight: AppTextStyles.body.fontWeight,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //Container(color: AppColors.secondaryColor, height: 1),
          Container(
            padding: EdgeInsets.all(8),
            color: AppColors.thirdColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rank',
                      style: TextStyle(
                          fontSize: 8, color: AppColors.secondaryColor),
                    ),
                    Text(
                      participant.rank,
                      style: TextStyle(
                        color: participant.rank == '1'
                            ? AppColors.green
                            : (participant.rank == '2'
                                ? AppColors.orange
                                : (participant.rank == '3'
                                    ? AppColors.primary
                                    : AppColors.secondaryColor)),
                        fontSize: AppTextStyles.heading.fontSize,
                        // backgroundColor: AppColors.thirdColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BIB',
                      style: TextStyle(
                          fontSize: 8, color: AppColors.secondaryColor),
                    ),
                    Text(
                      participant.bibNumber,
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: AppTextStyles.heading.fontSize,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 8, color: AppColors.secondaryColor),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          participant.firstName,
                          style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: AppTextStyles.heading.fontSize,
                              height: 1),
                        ),
                        Text(
                          participant.lastName,
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: AppTextStyles.body.fontWeight,
                              height: 1),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time Record',
                      style: TextStyle(
                          fontSize: 8, color: AppColors.secondaryColor),
                    ),
                    SizedBox(
                      height: AppSpacings.s,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              color: AppColors.cyan,
                              child: Text(
                                'Swimming',
                                style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: AppTextStyles.dropDown.fontSize),
                              ),
                            ),
                            SizedBox(
                              height: AppSpacings.s,
                            ),
                            Text(
                              swimmingTime,
                              style: AppTextStyles.dropDown,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Column(
                          children: [
                            Container(
                              color: AppColors.gold,
                              child: Text(
                                'Cycling',
                                style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: AppTextStyles.dropDown.fontSize),
                              ),
                            ),
                            SizedBox(
                              height: AppSpacings.s,
                            ),
                            Text(
                              cyclingTime,
                              style: AppTextStyles.dropDown,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Column(
                          children: [
                            Container(
                              color: AppColors.running,
                              child: Text(
                                'Running',
                                style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontSize: AppTextStyles.dropDown.fontSize),
                              ),
                            ),
                            SizedBox(
                              height: AppSpacings.s,
                            ),
                            Text(
                              runningTime,
                              style: AppTextStyles.dropDown,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

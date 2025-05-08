import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/widgets/action/race_button.dart';
import 'package:race_tracking_app_g14/UI/widgets/table/head.dart';
import 'package:race_tracking_app_g14/UI/widgets/time_count.dart';
import '../../../../models/participant/participant_model.dart';
import '../../../providers/async_value.dart';
import '../../../providers/participant_provider.dart';
import '../../../theme/theme.dart';

class TrackingTable extends StatelessWidget {
  final ParticipantProvider participantProvider;
  final Segment segment;
  const TrackingTable(
      {super.key, required this.participantProvider, required this.segment});

  @override
  Widget build(BuildContext context) {
    Widget content = const Text('Not Work');
    if (participantProvider.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (participantProvider.hasData) {
      List<Participant> fetchParticipant =
          participantProvider.participantState!.data!;

      if (fetchParticipant.isEmpty) {
        content = const Center(child: Text("No Progress Yet"));
      } else {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'Participant Tracking',
                    style: TextStyle(
                      fontSize: AppTextStyles.heading.fontSize,
                      fontWeight: AppTextStyles.heading.fontWeight,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Head(
                      first: 'BIB',
                      second: 'NAME',
                      third: 'TIME',
                      fourth: 'STATUS',
                    ),
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: fetchParticipant.length,
                          itemBuilder: (context, index) {
                            final currentDuration = segment == Segment.running
                                ? fetchParticipant[index].runningTime
                                : segment == Segment.swimming
                                    ? fetchParticipant[index].swimmingTime
                                    : fetchParticipant[index].cyclingTime;
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      fetchParticipant[index].bibNumber,
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight:
                                            AppTextStyles.body.fontWeight,
                                        backgroundColor: AppColors.thirdColor,
                                      ),
                                    ),
                                    Text(
                                      fetchParticipant[index].lastName,
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight:
                                            AppTextStyles.body.fontWeight,
                                      ),
                                    ),
                                    TimeCount(
                                        fontSize: AppTextStyles.label.fontSize!,
                                        fontWeight:
                                            AppTextStyles.label.fontWeight!,
                                        duration: currentDuration),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () =>
                                                participantProvider.stopTimer(
                                                    fetchParticipant[index]),
                                            icon: Icon(
                                              Icons.timer_off,
                                              color: AppColors.primary,
                                              size: 20,
                                            )),
                                        RaceButton(
                                          text: 'Finished',
                                          color: AppColors.green,
                                          onClick: () =>
                                              participantProvider.finishedTimer(
                                                  fetchParticipant[index]),
                                          width: 50,
                                          height: 17,
                                          textColor: AppColors.secondaryColor,
                                          fontSize: 12,
                                        )
                                      ],
                                    )
                                  ],
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    } else if (participantProvider.participantState?.state ==
        AsyncValueState.error) {
      content = Center(
        child: Text(
          'Error fetching data: ${participantProvider.participantState?.error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    return Container(child: content);
  }
}

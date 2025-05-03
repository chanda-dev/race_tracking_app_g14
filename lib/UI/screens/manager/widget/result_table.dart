import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/widgets/action/race_button.dart';
import '../../../../models/participant/participant_model.dart';
import '../../../providers/async_value.dart';
import '../../../providers/participant_provider.dart';
import '../../../theme/theme.dart';
import 'result_participants_card.dart';

class ResultTable extends StatelessWidget {
  const ResultTable({super.key});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
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
                    'Record',
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
              // Wrap the entire Column with Expanded
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('RANK',
                              style: TextStyle(color: AppColors.white)),
                          Text('BIB', style: TextStyle(color: AppColors.white)),
                          Text(
                            'NAME',
                            style: TextStyle(color: AppColors.white),
                          ),
                          Text(
                            'OVERALL TIME',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      // Ensure ListView.builder is inside an Expanded widget
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          itemCount: fetchParticipant.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: ResultParticipantsCard(
                                participant: fetchParticipant[index],
                              ),
                            );
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

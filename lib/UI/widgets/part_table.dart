import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/async_value.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/form_update_participant.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/UI/widgets/participate_cart.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

class PartTable extends StatelessWidget {
  const PartTable({super.key});

  @override
  Widget build(BuildContext context) {
    int participantAmount = 0;
    void onOpenParticipantForm() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSpacings.radius),
                    topRight: Radius.circular(AppSpacings.radius),
                  ),
                ),
                child: AddParticipantScreen(mode: Mode.add),
              ),
            ),
          );
        },
      );
    }

    final participantProvider = Provider.of<ParticipantProvider>(context);

    Widget content = const Text('');
    if (participantProvider.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (participantProvider.hasData) {
      List<Participant> fetchParticipant =
          participantProvider.participantState!.data!;

      if (fetchParticipant.isEmpty) {
        content = const Center(child: Text("Please Add participant"));
      } else {
        participantAmount = fetchParticipant.length;
        content = Expanded(
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              //shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemCount: fetchParticipant.length,
              itemBuilder: (context, index) {
                final participant = fetchParticipant[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: ParticipateCart(
                    participant: participant,
                    participantProvider: participantProvider,
                  ),
                );
              },
            ),
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                'List of Participants',
                style: TextStyle(
                  fontSize: AppTextStyles.heading.fontSize,
                  fontWeight: AppTextStyles.heading.fontWeight,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${participantAmount.toString()} P',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.person_add),
                onPressed: onOpenParticipantForm,
              ),
            ],
          ),
        ),
        Expanded(
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
                      Text('BIB', style: TextStyle(color: AppColors.white)),
                      Text(
                        'Name',
                        style: TextStyle(color: AppColors.white),
                      ),
                      Text('Age', style: TextStyle(color: AppColors.white)),
                    ],
                  ),
                ),
                content
              ],
            ),
          ),
        ),
      ],
    );
  }
}

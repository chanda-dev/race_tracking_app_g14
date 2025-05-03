import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/drop_down_provider.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/form_update_participant.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

class ParticipateCart extends StatelessWidget {
  final ParticipantProvider participantProvider;
  final Participant participant;
  const ParticipateCart({
    super.key,
    required this.participant,
    required this.participantProvider,
  });

  @override
  Widget build(BuildContext context) {
    void onDelete(Participant participant, BuildContext context) {
      participantProvider.deleteParticipant(participant.id);
      final snackBar = SnackBar(
        content: const Text('Participant deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            participantProvider.undoDeleteParticipant(participant);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void onEdit(Participant participant) {
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
                child: AddParticipantScreen(
                  mode: Mode.update,
                  participant: participant,
                ),
              ),
            ),
          );
        },
      );
    }

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
              participant.age.toString(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                participant.bibNumber,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: AppTextStyles.body.fontWeight,
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
                participant.age.toString(),
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: AppTextStyles.body.fontWeight,
                ),
              ),
            ],
          ),
          Container(color: AppColors.secondaryColor, height: 1),
          Container(
            color: AppColors.thirdColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => onDelete(participant, context),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onEdit(participant),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(color: AppColors.secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

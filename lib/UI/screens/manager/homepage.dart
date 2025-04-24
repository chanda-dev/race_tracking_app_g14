import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/table_participant.dart';
import 'package:race_tracking_app_g14/utils/animations_util.dart';

class Homepage extends StatelessWidget {
  final VoidCallback onOpenParticipantForm;
  const Homepage({super.key, required this.onOpenParticipantForm});

  @override
  Widget build(BuildContext context) {
    return ParticipantsBody(onOpenParticipantForm: onOpenParticipantForm);
  }
}

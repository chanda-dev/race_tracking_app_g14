import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/table_participant.dart';
import 'package:race_tracking_app_g14/utils/animations_util.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void onOpenParticipantForm() {
    Navigator.of(context).push(
      AnimationUtils.createTopToBottomRoute(
        ParticipantsBody(onOpenParticipantForm: onOpenParticipantForm),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ParticipantsBody(onOpenParticipantForm: onOpenParticipantForm);
  }
}

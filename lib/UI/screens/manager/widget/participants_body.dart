import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/widgets/part_table.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class ParticipantsBody extends StatelessWidget {
  const ParticipantsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: PartTable());
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

class AddParticipantScreen extends StatefulWidget {
  final Mode mode;
  final Participant? participant;
  const AddParticipantScreen({super.key, required this.mode, this.participant});

  @override
  State<AddParticipantScreen> createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void onAddParticipant(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      int age = int.tryParse(_ageController.text) ?? 0;
      if (widget.mode == Mode.add) {
        final ParticipantProvider participantProvider =
            context.read<ParticipantProvider>();
        List<Participant> participants =
            participantProvider.participantState!.data!;
        int bibNumber = participants.length + 1;
        participantProvider.addParticipant(
          bibNumber.toString(),
          firstName,
          lastName,
          age,
        );
        Navigator.pop(context);
      } else {
        final ParticipantProvider participantProvider =
            context.read<ParticipantProvider>();
        participantProvider.updateParticipant(
          widget.participant!.id,
          widget.participant!.bibNumber,
          firstName,
          lastName,
          age,
          widget.participant!.runningTime,
          widget.participant!.swimmingTime,
          widget.participant!.cyclingTime,
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.mode != Mode.add && widget.participant != null) {
      _firstNameController.text = widget.participant!.firstName;
      _ageController.text = widget.participant!.age.toString();
      _lastNameController.text = widget.participant!.lastName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            widget.mode == Mode.add ? "Add Participate" : "Update Participate",
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: AppTextStyles.title.fontWeight,
              fontSize: AppTextStyles.title.fontSize,
            ),
          ),
        ),
        const SizedBox(height: AppSpacings.m),
        Divider(color: AppColors.primary, thickness: 2),
        const SizedBox(height: AppSpacings.l),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Form(
                  key: _globalKey,
                  child: TextFormField(
                    controller: _firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input First Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "First name",
                      labelStyle: AppTextStyles.label.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSpacings.s),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacings.s),
              Expanded(
                child: TextFormField(
                  controller: _lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please input Last Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Last name",
                    labelStyle: AppTextStyles.label.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacings.s),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacings.s),
              Expanded(
                child: TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please input Age';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Age",
                    labelStyle: AppTextStyles.label.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacings.s),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacings.l),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.secondaryColor,
                shadowColor: Colors.transparent,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: Text("Cancel", style: AppTextStyles.button),
            ),
            const SizedBox(width: AppSpacings.s),
            ElevatedButton(
              onPressed: () => onAddParticipant(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 96, 229, 30),
                foregroundColor: AppColors.secondaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: Text(
                widget.mode == Mode.add ? "Add" : "Update",
                style: AppTextStyles.button,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacings.m),
        Container(
          height: 6,
          width: 80,
          decoration: BoxDecoration(
            color: AppColors.thirdColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

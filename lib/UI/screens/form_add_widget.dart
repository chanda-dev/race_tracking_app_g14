import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart'; // Ensure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Race Tracking App',
      debugShowCheckedModeBanner: false,
      theme: appTheme, // Make sure `appTheme` is defined in your theme.dart
      home: const AddParticipantScreen(),
    );
  }
}

class AddParticipantScreen extends StatelessWidget {
  const AddParticipantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Container(
          width: 400, // Changed from 60 to 600 for proper sizing
          padding: const EdgeInsets.all(AppSpacings.l),
          decoration: BoxDecoration(
            color: AppColors.backGroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Participant",
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: AppSpacings.m),
              Divider(color: AppColors.primary, thickness: 2),
              const SizedBox(height: AppSpacings.l),
              Row(
                children: [
                  Expanded(
                    child: TextField(
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
                  const SizedBox(width: AppSpacings.s),
                  Expanded(
                    child: TextField(
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
                    child: TextField(
                      keyboardType: TextInputType.number,
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
              const SizedBox(height: AppSpacings.l),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(240, 227, 227, 0),
                      foregroundColor: AppColors.secondaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text("Cancel", style: AppTextStyles.button),
                  ),
                  const SizedBox(width: AppSpacings.s),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 96, 229, 30),
                      foregroundColor: AppColors.secondaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text("Save", style: AppTextStyles.button),
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
          ),
        ),
      ),
    );
  }
}

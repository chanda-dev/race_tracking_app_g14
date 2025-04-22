import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/table_participant.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const HomeScreen(), // Call a new HomeScreen widget
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        elevation: 4.0,
        shadowColor: AppColors.thirdColor,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'RACE TRACKING ',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: AppTextStyles.heading.fontSize,
                  fontWeight: AppTextStyles.heading.fontWeight,
                ),
              ),
              Text(
                'APP',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: AppTextStyles.heading.fontSize,
                  fontWeight: AppTextStyles.heading.fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
      body: const ParticipantsBody(), // << ADD YOUR BODY HERE
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Participants',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

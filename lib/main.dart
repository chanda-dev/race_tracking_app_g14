import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/homepage.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/navbarpage.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/table_participant.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/data/repository/firebase_participant_repository.dart';
import 'package:race_tracking_app_g14/data/repository/participant_repostory.dart';
import 'package:race_tracking_app_g14/utils/animations_util.dart';

void main() {
  final ParticipantRepostory participantRepostory =
      FirebaseParticipantRepository();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ParticipantProvider(participantRepostory),
      child: MyApp(),
    ),
  );
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 2;

  void onOpenParticipantForm() {
    Navigator.of(context).push(
      AnimationUtils.createTopToBottomRoute(
        ParticipantsBody(onOpenParticipantForm: onOpenParticipantForm),
      ),
    );
  }

  void onIconTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
      body: Builder(
        builder: (BuildContext context) {
          if (selectedIndex == 0) {
            return Homepage(onOpenParticipantForm: onOpenParticipantForm);
          }
          return Center(child: Text('selectindex $selectedIndex'));
        },
      ),
      bottomNavigationBar: Navbarpage(
        selectedIndex: selectedIndex,
        onIconTap: onIconTap,
      ),
    );
  }
}

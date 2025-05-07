import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/drop_down_provider.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';
import 'package:race_tracking_app_g14/UI/providers/stop_watch_provider.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/homePage/homepage.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/participate_list/participate_list.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/results/results.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/start_race/start_race.dart';
import 'package:race_tracking_app_g14/UI/screens/manager/widget/navbarpage.dart';
import 'package:race_tracking_app_g14/UI/screens/tracker/screen/time_tracking.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';
import 'package:race_tracking_app_g14/data/repository/firebase_participant_repository.dart';
import 'package:race_tracking_app_g14/data/repository/participant_repostory.dart';

void main() {
  final ParticipantRepostory participantRepostory =
      FirebaseParticipantRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ParticipantProvider(participantRepostory),
        ),
        ChangeNotifierProvider(create: (context) => StopWatchProvider()),
        ChangeNotifierProvider(create: (context) => DropDownProvider())
      ],
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
  bool isClick = false;

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
        elevation: 1.0,
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
            return Homepage(
              amount: '26',
              onClick: () {},
            );
          } else if (selectedIndex == 3) {
            return Results();
          } else if (selectedIndex == 1) {
            return ParticipateList();
          } else if (selectedIndex == 4) {
            return TimeTracking();
          }
          return Center(child: StartRace());
        },
      ),
      bottomNavigationBar: Navbarpage(
        selectedIndex: selectedIndex,
        onIconTap: onIconTap,
      ),
    );
  }
}

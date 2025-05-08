import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';

class StopWatchProvider extends ChangeNotifier {
  Duration duration = const Duration();
  Timer? timer;
  bool isStart = true;
  void startTimer(BuildContext context) {
    final participantProvider =
        Provider.of<ParticipantProvider>(context, listen: false);
    participantProvider.startAllTimers();
    timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      duration += const Duration(seconds: 1);
      isStart = false;
      notifyListeners();
    });
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
    isStart = true;
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    duration = const Duration();
    notifyListeners();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchProvider extends ChangeNotifier {
  Duration duration = const Duration();
  Timer? timer;
  void startTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      duration += const Duration(seconds: 1);
      notifyListeners();
    });
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  void resetTimer() {
    stopTimer();
    duration = const Duration();
    notifyListeners();
  }
}

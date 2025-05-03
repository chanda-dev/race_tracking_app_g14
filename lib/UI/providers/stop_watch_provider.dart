import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchProvider extends ChangeNotifier {
  Duration duration = const Duration();
  Timer? timer;
  bool isStart = true;
  void startTimer() {
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

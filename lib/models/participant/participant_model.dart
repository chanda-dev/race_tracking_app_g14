import 'dart:async';

import 'package:race_tracking_app_g14/UI/providers/participant_provider.dart';

enum Mode { update, add }

class Participant {
  String rank;
  final String id;
  final String bibNumber;
  final String firstName;
  final String lastName;
  final int age;
  Duration runningTime;
  Duration swimmingTime;
  Duration cyclingTime;
  Segment currentSegment;
  Timer? timer;
  bool isUntracked;
  DateTime? untrackTime;

  Participant(
      {required this.rank,
      required this.id,
      required this.bibNumber,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.runningTime,
      required this.swimmingTime,
      required this.cyclingTime,
      this.currentSegment = Segment.running,
      this.timer,this.isUntracked = false,this.untrackTime});

  @override
  bool operator ==(Object other) {
    return other is Participant && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
}

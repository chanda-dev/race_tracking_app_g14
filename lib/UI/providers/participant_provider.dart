import 'dart:async';

import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/providers/async_value.dart';
import 'package:race_tracking_app_g14/UI/providers/noti_service.dart';
import 'package:race_tracking_app_g14/data/repository/participant_repostory.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

enum Segment {
  running('Running', Icons.directions_run),
  swimming('Swimming', Icons.pool),
  cycling('Cycling', Icons.directions_bike),
  finish('finish', Icons.close);

  final String name;
  final IconData icon;

  const Segment(this.name, this.icon);
}

class ParticipantProvider extends ChangeNotifier {
  final ParticipantRepostory _repository;

  AsyncValue<List<Participant>>? participantState;

  ParticipantProvider(this._repository) {
    fetchParticipant();
  }

  bool get isLoading =>
      participantState != null &&
      participantState!.state == AsyncValueState.loading;
  bool get hasData =>
      participantState != null &&
      participantState!.state == AsyncValueState.success;

  void fetchParticipant() async {
    try {
      participantState = AsyncValue.loading();
      notifyListeners();
      final participants = await _repository.getAllParticipant();
      participants.sort((a, b) {
        final aTotalTime = a.runningTime + a.swimmingTime + a.cyclingTime;
        final bTotalTime = b.runningTime + b.swimmingTime + b.cyclingTime;
        return aTotalTime.compareTo(bTotalTime);
      });
      participantState = AsyncValue.success(participants);
      updateRankings();
    } catch (error) {
      participantState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  void addParticipant(
    String rank,
    String bibNumber,
    String firstName,
    String lastName,
    int age, {
    Duration runningTime = Duration.zero,
    Duration swimmingTime = Duration.zero,
    Duration cyclingTime = Duration.zero,
  }) async {
    try {
      final newParticipant = await _repository.addParticipant(
        rank: rank,
        firstName: firstName,
        bibNumber: bibNumber,
        lastName: lastName,
        age: age,
        swimmingTime: swimmingTime,
        runningTime: runningTime,
        cyclingTime: cyclingTime,
      );

      if (participantState != null && participantState!.data != null) {
        participantState!.data!.add(newParticipant);
        notifyListeners();
      }

      fetchParticipant();
    } catch (error) {
      throw Exception('Failed to add participant: $error');
    }
  }

  void updateParticipant(
    String rank,
    String id,
    String bibNumber,
    String firstName,
    String lastName,
    int age,
    Duration runningTime,
    Duration swimmingTime,
    Duration cyclingTime,
  ) async {
    try {
      await _repository.updateParticipant(
        id: id,
        firstName: firstName,
        bibNumber: bibNumber,
        lastName: lastName,
        age: age,
        cyclingTime: cyclingTime,
        runningTime: runningTime,
        swimmingTime: swimmingTime,
        rank: rank,
      );
      fetchParticipant();
    } catch (error) {
      throw Exception('Failed to update participant: $error');
    }
  }

  void deleteParticipant(String id) async {
    if (hasData) {
      int index = participantState!.data!.indexWhere((p) => p.id == id);
      if (index == -1) {
        throw Exception("Student of id $id not found in the cache");
      }
      final removedParticipant = participantState!.data![index];
      participantState!.data!.removeAt(index);
      notifyListeners();
      try {
        await _repository.deleteParticipant(id: id);
      } catch (error) {
        participantState!.data!.insert(index, removedParticipant);
        notifyListeners();
      }
    } else {
      fetchParticipant();
    }
  }

  void undoDeleteParticipant(Participant participant) async {
    if (participantState != null && participantState!.data != null) {
      participantState!.data!.add(participant);
      notifyListeners();

      try {
        await _repository.addParticipant(
          rank: participant.rank,
          firstName: participant.firstName,
          bibNumber: participant.bibNumber,
          lastName: participant.lastName,
          age: participant.age,
          swimmingTime: participant.swimmingTime,
          runningTime: participant.runningTime,
          cyclingTime: participant.cyclingTime,
        );
      } catch (error) {
        throw Exception('Failed to undo delete: $error');
      }
    }
  }

  void startAllTimers() {
    final participants = participantState?.data ?? [];
    for (var participant in participants) {
      participant.timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
        if (participant.currentSegment == Segment.running) {
          participant.runningTime += const Duration(seconds: 1);
        } else if (participant.currentSegment == Segment.swimming) {
          participant.swimmingTime += const Duration(seconds: 1);
        } else if (participant.currentSegment == Segment.cycling) {
          participant.cyclingTime += const Duration(seconds: 1);
        }
        updateRankings();
        notifyListeners();
      });
      NotiService().showNotification(
          title: "Race Start",
          body: 'The race has start',
          payload: 'The race has start! Time Tracker prepare');
    }
  }

  void startTimer(Participant part) {
    final participant = participantState!.data!.firstWhere(
      (p) => p.id == part.id,
      orElse: () => throw Exception('Participant not found'),
    );
    participant.timer ??= Timer.periodic(Duration(seconds: 1), (_) {
      if (participant.currentSegment == Segment.running) {
        participant.runningTime += Duration(seconds: 1);
      } else if (participant.currentSegment == Segment.swimming) {
        participant.swimmingTime += Duration(seconds: 1);
      } else {
        participant.cyclingTime += Duration(seconds: 1);
      }

      updateRankings();
      notifyListeners();
    });
  }

  void stopTimer(Participant part) {
    final participant = participantState!.data!.firstWhere(
      (p) => p.id == part.id,
      orElse: () => throw Exception('Participant not found'),
    );
    participant.timer?.cancel();
    participant.timer = null;
    NotiService().showNotification(
        title: "Participant Complete",
        body:
            'Untrack participant ${participant.bibNumber} on segment ${participant.currentSegment.name}',
        payload:
            'Timer Tracker has untrack the participant ${participant.bibNumber} in segment ${participant.currentSegment.name}');
    notifyListeners();
  }

  void finishedTimer(Participant part) async {
    // Find the participant
    final participant = participantState!.data!.firstWhere(
      (p) => p.id == part.id,
      orElse: () => throw Exception('Participant not found'),
    );

    // Stop the timer for the specific participant
    stopTimer(participant);

    NotiService().showNotification(
        title: "Participant Complete",
        body:
            'Participant ${participant.bibNumber} has finish ${participant.currentSegment.name}',
        payload:
            ' participant ${participant.bibNumber} has finished the segment ${participant.currentSegment.name}');

    // Save the current segment time to the database
    await _repository.updateParticipant(
      id: participant.id,
      firstName: participant.firstName,
      bibNumber: participant.bibNumber,
      lastName: participant.lastName,
      age: participant.age,
      cyclingTime: participant.cyclingTime,
      runningTime: participant.runningTime,
      swimmingTime: participant.swimmingTime,
      rank: participant.rank,
    );

    // Move to the next segment
    if (participant.currentSegment == Segment.running) {
      participant.currentSegment = Segment.swimming;
    } else if (participant.currentSegment == Segment.swimming) {
      participant.currentSegment = Segment.cycling;
    } else if (participant.currentSegment == Segment.cycling) {
      participant.currentSegment = Segment.finish; // Mark as finished
    }

    // Restart the timer for the next segment
    if (participant.currentSegment != Segment.finish) {
      startTimer(participant);
    }

    // Notify listeners to update the UI for this specific participant
    notifyListeners();
  }

  void untrackParticipant(Participant participant) async {
    participant.isUntracked = true;
    participant.untrackTime = DateTime.now();

    await _repository.updateParticipant(
        rank: participant.rank,
        id: participant.id,
        firstName: participant.firstName,
        bibNumber: participant.bibNumber,
        lastName: participant.lastName,
        age: participant.age,
        swimmingTime: participant.swimmingTime,
        runningTime: participant.runningTime,
        cyclingTime: participant.cyclingTime);
    updateRankings();
    notifyListeners();
    NotiService().showNotification(
      title: 'Participant Untracked',
      body:
          'Untrack participant ${participant.bibNumber} on segment ${participant.currentSegment.name}',
    );
  }

  void updateRankings() {
    final participants = participantState!.data!;

    participants.sort((a, b) {
      if (a.isUntracked && b.isUntracked) {
        return 0;
      }
      if (a.isUntracked) return 1;
      if (b.isUntracked) return -1;

      Duration aTime = a.runningTime + a.swimmingTime + a.cyclingTime;
      Duration bTime = b.runningTime + b.swimmingTime + b.cyclingTime;
      return aTime.compareTo(bTime);
    });

    var nextRank = 1;
    for (final p in participants) {
      if (p.isUntracked) {
        p.rank = 'DNF';
      } else {
        p.rank = nextRank.toString();
        nextRank++;
      }
    }
    //int rank = 1;
    notifyListeners();
  }

  void updateParticipantTime(Participant participant, Duration newTime) async {
    switch (participant.currentSegment) {
      case Segment.running:
        participant.runningTime = newTime;
        break;
      case Segment.swimming:
        participant.swimmingTime = newTime;
        break;
      case Segment.cycling:
        participant.cyclingTime = newTime;
        break;
      case Segment.finish:
        break;
    }

    await _repository.updateParticipant(
        rank: participant.rank,
        id: participant.id,
        firstName: participant.firstName,
        bibNumber: participant.bibNumber,
        lastName: participant.lastName,
        age: participant.age,
        swimmingTime: participant.swimmingTime,
        runningTime: participant.runningTime,
        cyclingTime: participant.cyclingTime);
    updateRankings();
    notifyListeners();
  }
}

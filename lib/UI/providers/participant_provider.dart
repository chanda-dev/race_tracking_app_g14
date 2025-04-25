import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/providers/async_value.dart';
import 'package:race_tracking_app_g14/data/repository/participant_repostory.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

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
      participantState = AsyncValue.success(
        await _repository.getAllParticipant(),
      );
    } catch (error) {
      participantState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  void addParticipant(
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

      // await _repository.addParticipant(
      //   firstName: firstName,
      //   bibNumber: bibNumber,
      //   lastName: lastName,
      //   age: age,
      //   swimmingTime: swimmingTime,
      //   runningTime: runningTime,
      //   cyclingTime: cyclingTime,
      // );

      fetchParticipant();
    } catch (error) {
      throw Exception('Failed to add participant: $error');
    }
  }

  void updateParticipant(
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
      final removedStudent = participantState!.data![index];
      participantState!.data!.removeAt(index);
      notifyListeners();
      try {
        await _repository.deleteParticipant(id: id);
      } catch (error) {
        participantState!.data!.insert(index, removedStudent);
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
}

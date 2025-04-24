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
    int age,
  ) async {
    await _repository.addParticipant(
      firstName: firstName,
      bibNumber: bibNumber,
      lastName: lastName,
      age: age,
    );
    fetchParticipant();
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
}

import 'package:race_tracking_app_g14/models/participant/participant_model.dart';
import 'package:http/http.dart' as http;

abstract class ParticipantRepostory {
  Future<List<Participant>> getAllParticipant();
  Future<Participant> addParticipant({
    required String firstName,
    required String bibNumber,
    required String lastName,
    required int age,
    required Duration swimmingTime,
    required Duration runningTime,
    required Duration cyclingTime,
  });
  Future<void> updateParticipant({
    required String id,
    required String firstName,
    required String bibNumber,
    required String lastName,
    required int age,
    required Duration swimmingTime,
    required Duration runningTime,
    required Duration cyclingTime,
  });
  Future<http.Response> deleteParticipant({required String id});
}

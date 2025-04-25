import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:race_tracking_app_g14/data/dto/participant_dto.dart';
import 'package:race_tracking_app_g14/data/repository/participant_repostory.dart';
import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

class FirebaseParticipantRepository extends ParticipantRepostory {
  static const String baseUrl =
      'https://race-tracking-app-g14-default-rtdb.asia-southeast1.firebasedatabase.app/';
  static const String participantCollection = "participant";
  static const String allParticipantUlr =
      '$baseUrl/$participantCollection.json';
  Uri uri = Uri.parse(allParticipantUlr);

  @override
  Future<Participant> addParticipant({
    required String bibNumber,
    required int age,
    required String firstName,
    required String lastName,
    required Duration runningTime,
    required Duration swimmingTime,
    required Duration cyclingTime,
  }) async {
    // Create a new data
    final newParticipantData = {
      'bibNumber': bibNumber,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'runningTime': runningTime.inMilliseconds,
      'swimmingTime': swimmingTime.inMilliseconds,
      'cyclingTime': cyclingTime.inMilliseconds,
    };
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newParticipantData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to add participant');
    }

    // Firebase returns the new ID in 'bibNumber'
    final newId = json.decode(response.body)['name'];

    // Return created user
    return Participant(
      id: newId,
      firstName: firstName,
      age: age,
      lastName: lastName,
      bibNumber: bibNumber,
      runningTime: runningTime,
      swimmingTime: swimmingTime,
      cyclingTime: cyclingTime,
    );
  }

  @override
  Future<List<Participant>> getAllParticipant() async {
    final http.Response response = await http.get(uri);
    print('Response from Firebase: ${response.body}');
    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    // Return all users
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries
        .map((entry) => ParticipantDto.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  Future<http.Response> deleteParticipant({required String id}) async {
    Uri uriDelete = Uri.parse('$baseUrl/$participantCollection/$id.json');
    final http.Response response = await http.delete(
      uriDelete,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to delete student');
    }

    return response;
  }

  @override
  Future<Participant> updateParticipant({
    required String bibNumber,
    required String id,
    required String firstName,
    required String lastName,
    required int age,
    required Duration runningTime,
    required Duration swimmingTime,
    required Duration cyclingTime,
  }) async {
    final updateParticipant = {
      'bibNumber': bibNumber,
      'firstName': firstName,
      'age': age,
      'lastName': lastName,
      'runningTime': runningTime.inMilliseconds,
      'swimmingTime': swimmingTime.inMilliseconds,
      'cyclingTime': cyclingTime.inMilliseconds,
    };
    Uri uriUpdate = Uri.parse('$baseUrl/$participantCollection/$id.json');
    final http.Response response = await http.put(
      uriUpdate,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updateParticipant),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }

    // Return created user
    return Participant(
      id: id,
      bibNumber: bibNumber,
      firstName: firstName,
      age: age,
      lastName: lastName,
      runningTime: runningTime,
      cyclingTime: cyclingTime,
      swimmingTime: swimmingTime,
    );
  }
}

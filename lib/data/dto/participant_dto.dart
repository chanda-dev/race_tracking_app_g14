import 'package:race_tracking_app_g14/models/participant/participant_model.dart';

class ParticipantDto {
  static Map<String, dynamic> toJson(Participant model) {
    return {
      'bibNumber': model.bibNumber,
      'firstName': model.firstName,
      'lastName': model.lastName,
      'age': model.age,
      'runningTime': model.runningTime.inMilliseconds,
      'swimmingTime': model.swimmingTime.inMilliseconds,
      'cyclingTime': model.cyclingTime.inMilliseconds,
    };
  }

  static Participant fromJson(String id, Map<String, dynamic> json) {
    return Participant(
      id: id,
      bibNumber: json['bibNumber'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      age: json['age'] ?? 0,
      runningTime: Duration(milliseconds: json['runningTime'] ?? 0),
      swimmingTime: Duration(milliseconds: json['swimmingTime'] ?? 0),
      cyclingTime: Duration(milliseconds: json['cyclingTime'] ?? 0),
    );
  }
}

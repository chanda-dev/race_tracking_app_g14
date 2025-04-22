class Participant {
  final String id;
  final String bibNumber;
  final String firstName;
  final String lastName;
  final int age;
  final Duration runningTime;
  final Duration swimmingTime;
  final Duration cyclingTime;

  Participant({
    required this.id,
    required this.bibNumber,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.runningTime,
    required this.swimmingTime,
    required this.cyclingTime,
  });

  @override
  bool operator ==(Object other) {
    return other is Participant && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
}

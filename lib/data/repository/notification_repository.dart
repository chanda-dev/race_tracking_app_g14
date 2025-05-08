import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationRepository {
  Future<void> initNotification();
  NotificationDetails notificationDetails();
  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payload});
  void handleNotificationTap(String payload);
}

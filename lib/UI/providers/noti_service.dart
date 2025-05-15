import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:race_tracking_app_g14/data/repository/notification_repository.dart';
import 'package:race_tracking_app_g14/main.dart';

class NotiService extends NotificationRepository {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  final bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  @override
  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    const initSettings = InitializationSettings(
        android: initSettingsAndroid, iOS: initSettingsIOS);

    await notificationPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        handleNotificationTap(response.payload ?? '');
      },
    );
  }

  @override
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'race_tracking_app_g14', 'Daily Notifications',
            channelDescription: 'Daily Notification Chanel',
            importance: Importance.max,
            priority: Priority.high),
        iOS: DarwinNotificationDetails());
  }

  @override
  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    if (!_isInitialized) {
      await initNotification();
    }

    try {
      await notificationPlugin.show(id, title, body, notificationDetails(),
          payload: payload);
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  @override
  void handleNotificationTap(String payload) {
    print('Notification tapped with payload: $payload');

    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed('/notification', arguments: payload);
    }
  }
}

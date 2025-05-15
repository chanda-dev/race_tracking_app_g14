import 'package:flutter/material.dart';
import 'package:race_tracking_app_g14/UI/theme/theme.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? payload =
        ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Page'),
      ),
      body: Container(
        color: AppColors.secondaryColor,
        child: Center(
          child: Text(
            payload != null
                ? 'Notification Payload: $payload'
                : 'No Notification received',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

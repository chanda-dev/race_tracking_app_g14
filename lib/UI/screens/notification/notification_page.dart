import 'package:flutter/material.dart';

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
      body: Center(
        child: Text(
          payload != null
              ? 'Notification Payload: $payload'
              : 'No payload received',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

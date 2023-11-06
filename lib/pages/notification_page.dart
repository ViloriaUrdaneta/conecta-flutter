import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../services/notification_service.dart';


class NotificationPage extends StatelessWidget {
  final NotificationService notificationService;
  NotificationPage({Key? key, required this.notificationService}) : super(key: key);
  static const route = '/notification';
  

  @override
  Widget build(BuildContext context) {


    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage ;
    sendNotificationToApi(context, message);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),
                Text(
                  message.notification?.title ?? '',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  message.notification?.body ?? '',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> sendNotificationToApi(BuildContext context, RemoteMessage messageData) async {
    notificationService.sendNotificationToApi(messageData.data);
  }
}

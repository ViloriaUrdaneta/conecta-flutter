import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:conecta/providers/notification_provider.dart';

class MyNotification {
  final int id;
  final String title;
  final String message;
  final DateTime date;

  MyNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
  });
}

class NotificationService {
  final NotificationsProvider _notificationsProvider;

  NotificationService(this._notificationsProvider);

  Future<void> fetchAndSetNotifications() async {
    const apiUrl = 'https://api-laravel-pearl.vercel.app/notification';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final List<MyNotification> notifications = data.map((item) {
        return MyNotification(
          id: item['id'],
          title: item['title'],
          message: item['text'],
          date: DateTime.parse(item['created_at']),
        );
      }).toList();
      notifications.sort((a, b) => b.date.compareTo(a.date));
      final visibleNotifications = notifications.take(50).toList();
      _notificationsProvider.setNotifications(visibleNotifications);
    } else {
      throw Exception('Error al cargar las notificaciones');
    }
  }

  Future<void> sendNotificationToApi(Map<String, dynamic> notificationData) async {
    const apiUrl = 'https://api-laravel-pearl.vercel.app/newNotification';
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final String title = notificationData['notification']['title'];
    final String body = notificationData['notification']['body'];

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      print('Mensaje enviado con éxito a la API.');
      final List<dynamic> data = json.decode(response.body);

      final List<MyNotification> notifications = data.map((item) {
        return MyNotification(
          id: item['id'],
          title: item['title'],
          message: item['text'],
          date: DateTime.parse(item['created_at']),
        );
      }).toList();
      notifications.sort((a, b) => b.date.compareTo(a.date));
      final visibleNotifications = notifications.take(50).toList();
      _notificationsProvider.setNotifications(visibleNotifications);
    } else {
      print('Error al enviar el mensaje a la API: ${response.statusCode}');
    }
  }
}

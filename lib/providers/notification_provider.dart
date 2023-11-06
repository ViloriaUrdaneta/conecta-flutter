import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationsProvider extends ChangeNotifier {
  List<MyNotification> _notifications = [];

  List<MyNotification> get notifications => _notifications;

  void setNotifications(List<MyNotification> notifications) {
    _notifications = notifications;
    notifyListeners();
  }
}

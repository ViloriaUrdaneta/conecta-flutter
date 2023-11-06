import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/notification_provider.dart';
import '../services/notification_service.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    final notificationService = Provider.of<NotificationService>(context, listen: false);
    notificationService.fetchAndSetNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final notificationsProvider = Provider.of<NotificationsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          if (authProvider.getLastLogin() != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Último inicio de sesión: ${authProvider.getLastLogin()}'),
                  ],
                ),
              ),
            ),
          if (notificationsProvider.notifications.isEmpty)
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Center(child: Text('No hay notificaciones disponibles.')),
            ),
          if (notificationsProvider.notifications.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: notificationsProvider.notifications.length,
                itemBuilder: (context, index) {
                  final notification = notificationsProvider.notifications[index];
                  return ListTile(
                    title: Text(notification.title),
                    subtitle: Text(notification.message),
                    trailing: Text(
                      '${notification.date.day}/${notification.date.month}/${notification.date.year}',
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Provider.of<AuthProvider>(context, listen: false).signOut();
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Text('Cerrar Sesión'),
      ),
    );
  }
}

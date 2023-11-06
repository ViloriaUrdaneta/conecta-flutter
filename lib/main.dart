import 'package:conecta/pages/notification_page.dart';
import 'package:conecta/pages/signup_page.dart';
import 'package:conecta/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/dashboard_page.dart';
import 'pages/login_page.dart';
import 'providers/auth_provider.dart';
import 'services/notification_service.dart';
import 'package:conecta/api/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  final notificationsProvider = NotificationsProvider();
  final notificationService = NotificationService(notificationsProvider);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi(notificationService).initNotification();
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
        ChangeNotifierProvider<NotificationsProvider>.value(value: NotificationsProvider()),
        Provider<NotificationService>(create: (context) => NotificationService(Provider.of<NotificationsProvider>(context, listen: false))),
      ],
      child: MaterialApp(
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            if (authProvider.authToken != null) {
              return DashboardPage();
            } else {
              return const LoginPage();
            }
          },
        ),
        navigatorKey: navigatorKey,
        routes: {
          '/notification': (context) {
            final notificationService = Provider.of<NotificationService>(context, listen: false);
            return NotificationPage(notificationService: notificationService);
          }, 
          '/signup': (context) => const RegisterPage(), 
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/dashboard') {
            return MaterialPageRoute(
              builder: (context) => DashboardPage(),
            );
          } else if (settings.name == '/login') {
            return MaterialPageRoute(
              builder: (context) => const LoginPage(),
            );
          } else if (settings.name == '/notification') {
            final notificationService = Provider.of<NotificationService>(context, listen: false);
            return MaterialPageRoute(
              builder: (context) => NotificationPage(notificationService: notificationService),
            );
          } else if (settings.name == '/signuo') {
            return MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            );
          }
          return null;
        },
      ),
    );
  }
}





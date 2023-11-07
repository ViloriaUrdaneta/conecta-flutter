import 'dart:convert';
import 'package:conecta/main.dart';
import 'package:conecta/pages/notification_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/notification_service.dart';
import 'token_manager.dart';

Future<void>handleBackgroundMessage(RemoteMessage message)async{
  print('Title in handleBackgroundMessage: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}


class FirebaseApi {
  
  final _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationService notificationsService;

  FirebaseApi(this.notificationsService);
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message){

    if ( message == null ) return;

    //notificationsService.sendNotificationToApi(message.data);
    navigatorKey.currentState?.pushNamed(
      NotificationPage.route,
      arguments: message,
    );
  }


  Future initLocalNotifications() async{
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);
  
    await _localNotifications.initialize(
      
      settings,
      onDidReceiveNotificationResponse: (payload){
        final Map<String, dynamic> payloadData = jsonDecode(payload.payload as String);
        final String title = payloadData['notification']['title'];
        final String body = payloadData['notification']['body'];
        final message = RemoteMessage(
          data: payloadData,  // Puedes usar payloadData directamente como datos
          notification: RemoteNotification(
            title: title,
            body: body,
          ),
        );
        handleMessage(message);
      }
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }


  Future initPushNotifications()async{
    await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode, 
        notification.title, 
        notification.body, 
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id, 
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher'
            )
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }



  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken =  await _firebaseMessaging.getToken();
    FCMTokenManager.instance.setToken(fCMToken!);
    print('Token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }
}
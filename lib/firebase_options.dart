// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA44xfco7O0yHTiETaXAKg49XA_MEoSuck',
    appId: '1:1043939757309:web:9d08ba34c52b8266cf4294',
    messagingSenderId: '1043939757309',
    projectId: 'push-notifications-bd91c',
    authDomain: 'push-notifications-bd91c.firebaseapp.com',
    storageBucket: 'push-notifications-bd91c.appspot.com',
    measurementId: 'G-W65DD33DJV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBRoA7nBZhUzjnhgPweffy4QUhOX8FiEg',
    appId: '1:1043939757309:android:066a9025df639028cf4294',
    messagingSenderId: '1043939757309',
    projectId: 'push-notifications-bd91c',
    storageBucket: 'push-notifications-bd91c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqsKZGXACzCk7-ZN63HI1RcRAudzSdQkQ',
    appId: '1:1043939757309:ios:9a724cb6470f5a91cf4294',
    messagingSenderId: '1043939757309',
    projectId: 'push-notifications-bd91c',
    storageBucket: 'push-notifications-bd91c.appspot.com',
    iosBundleId: 'com.example.conecta',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqsKZGXACzCk7-ZN63HI1RcRAudzSdQkQ',
    appId: '1:1043939757309:ios:cf4ad67107d9f6bccf4294',
    messagingSenderId: '1043939757309',
    projectId: 'push-notifications-bd91c',
    storageBucket: 'push-notifications-bd91c.appspot.com',
    iosBundleId: 'com.example.conecta.RunnerTests',
  );
}

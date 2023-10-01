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
///

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
    apiKey: 'AIzaSyDQofEha9aIN-HuDXwwkpXpgTsau7Y8xgU',
    appId: '1:429553766653:web:0b1b0672bee1c6742eee94',
    messagingSenderId: '429553766653',
    projectId: 'calendario-hemofilico',
    authDomain: 'calendario-hemofilico.firebaseapp.com',
    storageBucket: 'calendario-hemofilico.appspot.com',
    measurementId: 'G-KCMBSG6YBF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqS08WkhAHgeYELhjOMXO60kkjE0HsJiw',
    appId: '1:429553766653:android:ef91eddb5ce83d542eee94',
    messagingSenderId: '429553766653',
    projectId: 'calendario-hemofilico',
    storageBucket: 'calendario-hemofilico.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy6xhOgJLG6IPdUHHrZxtGo0NkmzLACII',
    appId: '1:429553766653:ios:6944ce3aa9d8214b2eee94',
    messagingSenderId: '429553766653',
    projectId: 'calendario-hemofilico',
    storageBucket: 'calendario-hemofilico.appspot.com',
    iosClientId:
        '429553766653-h4fl8s79nse7tbhej7r73ide23qs0tbd.apps.googleusercontent.com',
    iosBundleId: 'com.example.calendario',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAy6xhOgJLG6IPdUHHrZxtGo0NkmzLACII',
    appId: '1:429553766653:ios:6944ce3aa9d8214b2eee94',
    messagingSenderId: '429553766653',
    projectId: 'calendario-hemofilico',
    storageBucket: 'calendario-hemofilico.appspot.com',
    iosClientId:
        '429553766653-h4fl8s79nse7tbhej7r73ide23qs0tbd.apps.googleusercontent.com',
    iosBundleId: 'com.example.calendario',
  );
}

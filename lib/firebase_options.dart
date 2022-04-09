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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAvXLWTvMd9lmOJ34pe1VesKKtLJwXYVOU',
    appId: '1:897972232792:web:beca4d712e91839672a02d',
    messagingSenderId: '897972232792',
    projectId: 'yearbookmaker-f4ed4',
    authDomain: 'yearbookmaker-f4ed4.firebaseapp.com',
    storageBucket: 'yearbookmaker-f4ed4.appspot.com',
    measurementId: 'G-0CB17QPJ7Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXbaU5GT91yIXGrK_xoO0b0gxK3kI4L5o',
    appId: '1:897972232792:android:672843a8bf52e4a172a02d',
    messagingSenderId: '897972232792',
    projectId: 'yearbookmaker-f4ed4',
    storageBucket: 'yearbookmaker-f4ed4.appspot.com',
  );
}

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDtrbETZWgv4al8imNbJY4vZyUGUa99Cic',
    appId: '1:1012580107522:web:2b59a410d41ddadc44ee1b',
    messagingSenderId: '1012580107522',
    projectId: 'flutter-yaber-test',
    authDomain: 'flutter-yaber-test.firebaseapp.com',
    storageBucket: 'flutter-yaber-test.appspot.com',
    measurementId: 'G-BQT970N8YX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEUpBWKlOyCs1C4TOSre5mO1k5a10Eeu8',
    appId: '1:1012580107522:android:148a57c2f3067fe044ee1b',
    messagingSenderId: '1012580107522',
    projectId: 'flutter-yaber-test',
    storageBucket: 'flutter-yaber-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqGZOmX8UXodBPQ1Bnd6p2pNNHMWRpsm8',
    appId: '1:1012580107522:ios:c51d208be9d9e88444ee1b',
    messagingSenderId: '1012580107522',
    projectId: 'flutter-yaber-test',
    storageBucket: 'flutter-yaber-test.appspot.com',
    iosClientId: '1012580107522-4ordte31qhmpn58en8meiqg3igv9q5a5.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterYaber',
  );
}

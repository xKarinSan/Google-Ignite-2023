// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
// / Example:
// / ```dart
// / import 'firebase_options.dart';
// / // ...
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
// / ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZ6Pikl2yvU8iig3KabNbnV9Q3kLM5yjQ',
    appId: '1:547151558406:android:7af223b05728ec28181087',
    messagingSenderId: '547151558406',
    projectId: 'ignite-2023-67a01',
    databaseURL:
        'https://ignite-2023-67a01-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ignite-2023-67a01.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDH19_dqgVtfvp2oQHXsWzglRJrztJMbjw',
    appId: '1:547151558406:ios:09bde75aa2ec6bee181087',
    messagingSenderId: '547151558406',
    projectId: 'ignite-2023-67a01',
    databaseURL:
        'https://ignite-2023-67a01-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ignite-2023-67a01.appspot.com',
    iosClientId:
        '547151558406-pq2njp7s6bvl8sd09m162h0b5d2tnv5b.apps.googleusercontent.com',
    iosBundleId: 'com.example.googleignite2023',
  );
}

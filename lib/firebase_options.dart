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
    apiKey: 'AIzaSyBN_MdY1j8VbQO9gLfKdemk5P9VQDN7Yyw',
    appId: '1:609047605329:web:5d07136a8ecbf29e4d8870',
    messagingSenderId: '609047605329',
    projectId: 'boarded-68034',
    authDomain: 'boarded-68034.firebaseapp.com',
    storageBucket: 'boarded-68034.appspot.com',
    measurementId: 'G-15JJ9CQ1CZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbvfy1rhgnOwU-qxM1GGt8vcxbBjalpcw',
    appId: '1:609047605329:android:742cb6867ced491e4d8870',
    messagingSenderId: '609047605329',
    projectId: 'boarded-68034',
    storageBucket: 'boarded-68034.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIiDnUQTVGkfLaKtr1tjqR8kY7kUwuxSU',
    appId: '1:609047605329:ios:ab00f114f2b072fd4d8870',
    messagingSenderId: '609047605329',
    projectId: 'boarded-68034',
    storageBucket: 'boarded-68034.appspot.com',
    iosClientId: '609047605329-703gahv9pei7fte6eibs5im6f4qg613n.apps.googleusercontent.com',
    iosBundleId: 'com.example.boarded',
  );
}

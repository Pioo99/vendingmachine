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
    apiKey: 'AIzaSyALfH0eULyZ9JU0ithDPlf_7RdGNSUClXw',
    appId: '1:82828345213:web:50b4e00437274f503c9614',
    messagingSenderId: '82828345213',
    projectId: 'vending-machine-a1833',
    authDomain: 'vending-machine-a1833.firebaseapp.com',
    databaseURL: 'https://vending-machine-a1833-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'vending-machine-a1833.appspot.com',
    measurementId: 'G-XDR61L2R56',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJAJSfXEHTy-lDd6AmAzjryjTWAVdU64E',
    appId: '1:82828345213:android:0d0b542b0ac69d763c9614',
    messagingSenderId: '82828345213',
    projectId: 'vending-machine-a1833',
    databaseURL: 'https://vending-machine-a1833-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'vending-machine-a1833.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-7FM0bSRDc5hM59vk5qJpo225IwHXLIg',
    appId: '1:82828345213:ios:42f99568917dd6833c9614',
    messagingSenderId: '82828345213',
    projectId: 'vending-machine-a1833',
    databaseURL: 'https://vending-machine-a1833-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'vending-machine-a1833.appspot.com',
    iosClientId: '82828345213-k8j935ohdjln1moohg07rgfon96rn5d5.apps.googleusercontent.com',
    iosBundleId: 'com.example.vendingmachine',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-7FM0bSRDc5hM59vk5qJpo225IwHXLIg',
    appId: '1:82828345213:ios:4a4aa753fa6f08333c9614',
    messagingSenderId: '82828345213',
    projectId: 'vending-machine-a1833',
    databaseURL: 'https://vending-machine-a1833-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'vending-machine-a1833.appspot.com',
    iosClientId: '82828345213-738bpcph0irm4tf4t6n8pg4pk3cn7tf9.apps.googleusercontent.com',
    iosBundleId: 'com.example.vendingmachine.RunnerTests',
  );
}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCLY1shZ4elrn0kaH75vz8oUR73xWm-eTw',
    appId: '1:623586099748:web:54ad9cdae236b46bad4eb1',
    messagingSenderId: '623586099748',
    projectId: 'completefirebase-e0178',
    authDomain: 'completefirebase-e0178.firebaseapp.com',
    storageBucket: 'completefirebase-e0178.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAb_hWKXtiY10VgtW9amjdyX5vf_KBu4zA',
    appId: '1:623586099748:android:5062e485d36a9717ad4eb1',
    messagingSenderId: '623586099748',
    projectId: 'completefirebase-e0178',
    storageBucket: 'completefirebase-e0178.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCW4CDHOWcapqF5qv_eXj3TCJYfQcyWCok',
    appId: '1:623586099748:ios:3c8576f613c3b141ad4eb1',
    messagingSenderId: '623586099748',
    projectId: 'completefirebase-e0178',
    storageBucket: 'completefirebase-e0178.firebasestorage.app',
    iosBundleId: 'com.firebase.firebaseComplete',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCW4CDHOWcapqF5qv_eXj3TCJYfQcyWCok',
    appId: '1:623586099748:ios:3c8576f613c3b141ad4eb1',
    messagingSenderId: '623586099748',
    projectId: 'completefirebase-e0178',
    storageBucket: 'completefirebase-e0178.firebasestorage.app',
    iosBundleId: 'com.firebase.firebaseComplete',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCLY1shZ4elrn0kaH75vz8oUR73xWm-eTw',
    appId: '1:623586099748:web:255ecab03d1baabfad4eb1',
    messagingSenderId: '623586099748',
    projectId: 'completefirebase-e0178',
    authDomain: 'completefirebase-e0178.firebaseapp.com',
    storageBucket: 'completefirebase-e0178.firebasestorage.app',
  );
}

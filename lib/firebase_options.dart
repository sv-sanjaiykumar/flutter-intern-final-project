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
    apiKey: 'AIzaSyBzRm0qiInR9rRkid7ujDuHgmYTJG82HaM',
    appId: '1:704729598980:web:6f8c1d22e38c96f9e9f951',
    messagingSenderId: '704729598980',
    projectId: 'habit-9d530',
    authDomain: 'habit-9d530.firebaseapp.com',
    storageBucket: 'habit-9d530.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5fQ5m_OSQPj3nSuwSYCz9t_QJBUAUnYg',
    appId: '1:704729598980:android:c7bbb9c424385debe9f951',
    messagingSenderId: '704729598980',
    projectId: 'habit-9d530',
    storageBucket: 'habit-9d530.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAijyEzaTNUhl7CcC_Ne3JJB0hJpuwtKII',
    appId: '1:704729598980:ios:d929d4d9fdb3a0f7e9f951',
    messagingSenderId: '704729598980',
    projectId: 'habit-9d530',
    storageBucket: 'habit-9d530.firebasestorage.app',
    iosBundleId: 'com.example.habitApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAijyEzaTNUhl7CcC_Ne3JJB0hJpuwtKII',
    appId: '1:704729598980:ios:d929d4d9fdb3a0f7e9f951',
    messagingSenderId: '704729598980',
    projectId: 'habit-9d530',
    storageBucket: 'habit-9d530.firebasestorage.app',
    iosBundleId: 'com.example.habitApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBzRm0qiInR9rRkid7ujDuHgmYTJG82HaM',
    appId: '1:704729598980:web:e322ffd969cfee62e9f951',
    messagingSenderId: '704729598980',
    projectId: 'habit-9d530',
    authDomain: 'habit-9d530.firebaseapp.com',
    storageBucket: 'habit-9d530.firebasestorage.app',
  );
}

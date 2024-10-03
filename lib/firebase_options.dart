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
    apiKey: 'AIzaSyDqbwV90jallunNIkYDfYaesE491dexBq0',
    appId: '1:400885567198:web:ac47381953b77449b27c4f',
    messagingSenderId: '400885567198',
    projectId: 'gotogrocery-15ced',
    authDomain: 'gotogrocery-15ced.firebaseapp.com',
    storageBucket: 'gotogrocery-15ced.appspot.com',
    measurementId: 'G-WJHMQYF09L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhy47XNbK_Bd8tA3yny-1RJ5g-QBBgb5w',
    appId: '1:400885567198:android:8f88a40df3d2ff23b27c4f',
    messagingSenderId: '400885567198',
    projectId: 'gotogrocery-15ced',
    storageBucket: 'gotogrocery-15ced.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjYyzp8vS3bfbkQu9K0aLNKvGL4JUCXF0',
    appId: '1:400885567198:ios:a7c8f762aa0c9ad8b27c4f',
    messagingSenderId: '400885567198',
    projectId: 'gotogrocery-15ced',
    storageBucket: 'gotogrocery-15ced.appspot.com',
    iosBundleId: 'com.example.gotogrocery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjYyzp8vS3bfbkQu9K0aLNKvGL4JUCXF0',
    appId: '1:400885567198:ios:a7c8f762aa0c9ad8b27c4f',
    messagingSenderId: '400885567198',
    projectId: 'gotogrocery-15ced',
    storageBucket: 'gotogrocery-15ced.appspot.com',
    iosBundleId: 'com.example.gotogrocery',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDqbwV90jallunNIkYDfYaesE491dexBq0',
    appId: '1:400885567198:web:d6bf9e0bc28b731eb27c4f',
    messagingSenderId: '400885567198',
    projectId: 'gotogrocery-15ced',
    authDomain: 'gotogrocery-15ced.firebaseapp.com',
    storageBucket: 'gotogrocery-15ced.appspot.com',
    measurementId: 'G-NS2JZTVNHE',
  );
}

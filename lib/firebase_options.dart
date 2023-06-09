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
    apiKey: 'AIzaSyDjvFX7ZxxTbhzRP0dXfKLZ4D2rDvoe0nw',
    appId: '1:151773463580:web:5c82548532ba8d5705cbd9',
    messagingSenderId: '151773463580',
    projectId: 'e-commerce-b9cf6',
    authDomain: 'e-commerce-b9cf6.firebaseapp.com',
    storageBucket: 'e-commerce-b9cf6.appspot.com',
    measurementId: 'G-BRFFMNJKR6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAV12WRMLVdLpp_fIEeqhk8xTgyZLtg-6s',
    appId: '1:151773463580:android:7afd4fee374f93b705cbd9',
    messagingSenderId: '151773463580',
    projectId: 'e-commerce-b9cf6',
    storageBucket: 'e-commerce-b9cf6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDsDKw_JHdJgB1Zf5pouQQJ1lGswH99M84',
    appId: '1:151773463580:ios:cd4fef624b10ed6305cbd9',
    messagingSenderId: '151773463580',
    projectId: 'e-commerce-b9cf6',
    storageBucket: 'e-commerce-b9cf6.appspot.com',
    iosClientId: '151773463580-na3pdd651rg31b43ue40096d2n4q3071.apps.googleusercontent.com',
    iosBundleId: 'com.ecommerce.ecommerceProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDsDKw_JHdJgB1Zf5pouQQJ1lGswH99M84',
    appId: '1:151773463580:ios:cd4fef624b10ed6305cbd9',
    messagingSenderId: '151773463580',
    projectId: 'e-commerce-b9cf6',
    storageBucket: 'e-commerce-b9cf6.appspot.com',
    iosClientId: '151773463580-na3pdd651rg31b43ue40096d2n4q3071.apps.googleusercontent.com',
    iosBundleId: 'com.ecommerce.ecommerceProject',
  );
}

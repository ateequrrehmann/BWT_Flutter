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
    apiKey: 'AIzaSyBteM9T1pFkcpmnt77Y1Ivp2hCayR2y-V8',
    appId: '1:170586897011:web:dae224624cd70d962c4806',
    messagingSenderId: '170586897011',
    projectId: 'mahircompanyclone',
    authDomain: 'mahircompanyclone.firebaseapp.com',
    storageBucket: 'mahircompanyclone.appspot.com',
    measurementId: 'G-21FWL11Z80',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlZndmPzmfLuMf4QXdoa6mm8z-rBmpygA',
    appId: '1:170586897011:android:bfd91c334511a3aa2c4806',
    messagingSenderId: '170586897011',
    projectId: 'mahircompanyclone',
    storageBucket: 'mahircompanyclone.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwUQl7Lb4ErN3_Oy9zZfM9ELIjnE2gsEg',
    appId: '1:170586897011:ios:ad4194fe44dbfa3d2c4806',
    messagingSenderId: '170586897011',
    projectId: 'mahircompanyclone',
    storageBucket: 'mahircompanyclone.appspot.com',
    iosBundleId: 'com.example.task6ECommerceMahirCompanyClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwUQl7Lb4ErN3_Oy9zZfM9ELIjnE2gsEg',
    appId: '1:170586897011:ios:ad4194fe44dbfa3d2c4806',
    messagingSenderId: '170586897011',
    projectId: 'mahircompanyclone',
    storageBucket: 'mahircompanyclone.appspot.com',
    iosBundleId: 'com.example.task6ECommerceMahirCompanyClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBteM9T1pFkcpmnt77Y1Ivp2hCayR2y-V8',
    appId: '1:170586897011:web:a291db8882d05e782c4806',
    messagingSenderId: '170586897011',
    projectId: 'mahircompanyclone',
    authDomain: 'mahircompanyclone.firebaseapp.com',
    storageBucket: 'mahircompanyclone.appspot.com',
    measurementId: 'G-TJR1TFYKRK',
  );
}
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_WEB')}',
    appId: '1:245814539876:web:116c56666a2ff3ff245171',
    messagingSenderId: '245814539876',
    projectId: 'concentrated-c2d3d',
    authDomain: 'concentrated-c2d3d.firebaseapp.com',
    storageBucket: 'concentrated-c2d3d.firebasestorage.app',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_ANDROID')}',
    appId: '1:245814539876:android:0db34e32ff33dca7245171',
    messagingSenderId: '245814539876',
    projectId: 'concentrated-c2d3d',
    storageBucket: 'concentrated-c2d3d.firebasestorage.app',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_IOS')}',
    appId: '1:245814539876:ios:4adc4a2c670a7ac0245171',
    messagingSenderId: '245814539876',
    projectId: 'concentrated-c2d3d',
    storageBucket: 'concentrated-c2d3d.firebasestorage.app',
    iosBundleId: 'com.example.tweleveAce',
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_MAC')}',
    appId: '1:245814539876:ios:4adc4a2c670a7ac0245171',
    messagingSenderId: '245814539876',
    projectId: 'concentrated-c2d3d',
    storageBucket: 'concentrated-c2d3d.firebasestorage.app',
    iosBundleId: 'com.example.tweleveAce',
  );

  static FirebaseOptions windows = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_WIND')}',
    appId: '1:245814539876:web:08ada8a66f71e80d245171',
    messagingSenderId: '245814539876',
    projectId: 'concentrated-c2d3d',
    authDomain: 'concentrated-c2d3d.firebaseapp.com',
    storageBucket: 'concentrated-c2d3d.firebasestorage.app',
  );
}

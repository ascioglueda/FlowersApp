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
    apiKey: 'AIzaSyAHIRS2ctQeSIkkwq-Ta99SQxSs0pmx-IE',
    appId: '1:482908904509:web:3129fe02649a92ca0d1e54',
    messagingSenderId: '482908904509',
    projectId: 'flowersapp-fbd8b',
    authDomain: 'flowersapp-fbd8b.firebaseapp.com',
    storageBucket: 'flowersapp-fbd8b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoU4Tw12DfdpkZAQZC1pIb2nfUYGFirlE',
    appId: '1:482908904509:android:9e326be488683ad50d1e54',
    messagingSenderId: '482908904509',
    projectId: 'flowersapp-fbd8b',
    storageBucket: 'flowersapp-fbd8b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCC8B6F9ZdDhrPq9UH3Ev06uXpd5sHhcKk',
    appId: '1:482908904509:ios:fb5738dc3cbbe4ef0d1e54',
    messagingSenderId: '482908904509',
    projectId: 'flowersapp-fbd8b',
    storageBucket: 'flowersapp-fbd8b.firebasestorage.app',
    iosBundleId: 'com.example.flowersapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCC8B6F9ZdDhrPq9UH3Ev06uXpd5sHhcKk',
    appId: '1:482908904509:ios:fb5738dc3cbbe4ef0d1e54',
    messagingSenderId: '482908904509',
    projectId: 'flowersapp-fbd8b',
    storageBucket: 'flowersapp-fbd8b.firebasestorage.app',
    iosBundleId: 'com.example.flowersapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAHIRS2ctQeSIkkwq-Ta99SQxSs0pmx-IE',
    appId: '1:482908904509:web:7fc697b4ecb09bd10d1e54',
    messagingSenderId: '482908904509',
    projectId: 'flowersapp-fbd8b',
    authDomain: 'flowersapp-fbd8b.firebaseapp.com',
    storageBucket: 'flowersapp-fbd8b.firebasestorage.app',
  );
}

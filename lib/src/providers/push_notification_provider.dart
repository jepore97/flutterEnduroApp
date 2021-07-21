import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print("----------token----------");
      print(token);
      // cnjJtrAQRJ-88acNisKTll:APA91bEqkkEyowkt0Ull8HEuYpzQlFouBJ9tkcAv2ospkX36aNBYFrdD15pZycnf_2v0lPlJ_OfEluvPJLmDWkQvT0aJsO2OUGGcTDd_U6NFjVodV4UNvQaiX71i9_qRGoVAMSIRQFpe
    });
    _firebaseMessaging.configure(
      onMessage: (message) async {
        print("============on message============");
        print(message);
        String argumento = 'no-data';
        if (Platform.isAndroid) {
          argumento = message['data']['valor'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
      },
      onLaunch: (message) async {
        print(message);
      },
      onResume: (message) async {
        print("============on resume============");
        print(message);
      },
    );
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}

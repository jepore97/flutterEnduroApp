import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

import '../../main.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((tokenfcm) {
      App.localStorage.setString('tokenfcm', tokenfcm);
    });
    _firebaseMessaging.configure(
      onMessage: (message) async {
        print(json.encode(message['data']));
        String argumento = 'no-data';
        if (Platform.isAndroid) {
          argumento = json.encode(message['data']).toString() ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
      },
      onLaunch: (message) async {
        print(message);
      },
      onResume: (message) async {
        print(message);
      },
    );
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}

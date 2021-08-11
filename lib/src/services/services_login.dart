import 'dart:convert';

import 'package:ui_flutter/src/services/service_url.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class ServicioLogin {
  String url = Url().getUrl();
  Future<Login> signin(String email, String password) async {
    http.Response response;
    Login login;
    try {
      print(App.localStorage.getString('tokenfcm'));
      response = await http.post(url + 'auth/signin', body: {
        "email": email,
        "password": password,
        "tokenfcm": App.localStorage.getString('tokenfcm')
      }).timeout(Duration(seconds: 30));
      final jsonResponse = json.decode(response.body);
      login = Login.fromJson(jsonResponse);
      return login;
    } catch (e) {
      return login;
    }
  }
}

class Login {
  bool status;
  String message;
  String token;
  Login({this.status, this.message, this.token});
  factory Login.fromJson(Map<String, dynamic> json) {
    return new Login(
      status: json['status'],
      message: json['message'],
      token: json['token'],
    );
  }
}

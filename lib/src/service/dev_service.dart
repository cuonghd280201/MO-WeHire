// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_hire/src/constants/values.dart';
import 'package:we_hire/src/features/authentication/models/user.dart';

class DevService {
  final String apiUrl;
  final String jwtSecret;
  DevService({required this.apiUrl, required this.jwtSecret});

  Future<void> SignIn(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$apiServer/Account/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var deviceToken = await FirebaseMessaging.instance.getToken();
      print(deviceToken);
      final body = await json.decode(response.body);
      final data = body['data'];
      prefs.setString('accessToken', data['accessToken']);
      prefs.setInt('devId', data['devId']);
      prefs.setInt('userId', data['userId']);

      devId = data['devId'].toString();
      postUserDevie(deviceToken!);
      JWT_TOKEN_VALUE = data['token'].toString();
      IS_CONFIRM_VALUE = data['isConfirm'].toString();
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> postUserDevie(String deviceToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    int? userId = prefs.getInt('userId');
    final response = await http.post(
      Uri.parse('$apiServer/UserDevice'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userId": '$userId',
        "deviceToken": deviceToken,
      }),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<List<User>> getUserInfo(int? userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    userId = prefs.getInt('devId');
    final response = await http.get(
      Uri.parse('$apiServer/api/User/$userId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> requestData = data['data'];
      return requestData
          .map((data) => User.fromJson(data))
          .toList()
          .cast<User>();
    }
    return [];
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';
import 'package:http/http.dart' as http;

class Netword {
  static const String url =
      'https://wehireapi.azurewebsites.net/api/HiringRequest/ByDev';

  static List<HiringNew> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<HiringNew> hirings =
        list.map((model) => HiringNew.fromJson(model)).toList();
    return hirings;
  }

  static Future<List<HiringNew>> fetchPosts(String devId, String status) async {
    final response = await http.get(Uri.parse('$url/$devId'));
    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

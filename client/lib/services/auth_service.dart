import 'dart:convert';
import 'package:client/services/config.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static registerUser(reqBody) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(reqBody),
    );
    return response;
  }

  static loginUser(reqBody) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(reqBody),
    );
    return response;
  }
}

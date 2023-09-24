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

  static updateUser(id, reqBody) async {
    final uri = '$updateUrl/$id';
    final response = await http.put(
      Uri.parse(uri),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    return response;
  }

  static deleteUser(id) async {
    final uri = '$deleteUrl/$id';
    final response = await http.delete(
      Uri.parse(uri),
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  static searchUser(text, token) async {
    final uri = '$userUrl?search=$text';
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }
}

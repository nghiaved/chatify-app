import 'dart:convert';
import 'package:client/services/config.dart';
import 'package:http/http.dart' as http;

class ChatService {
  static fetchChats(token) async {
    final response = await http.get(
      Uri.parse(chatUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  static createChat(userId, token) async {
    final response = await http.post(
      Uri.parse(chatUrl),
      headers: {
        'content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"userId": userId}),
    );
    return response;
  }
}

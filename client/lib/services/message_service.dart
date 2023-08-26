import 'dart:convert';
import 'package:client/services/config.dart';
import 'package:http/http.dart' as http;

class MessageService {
  static fetchMessages(token, chatId) async {
    final uri = '$messageUrl/$chatId';
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

  static sendMessage(token, reqBody) async {
    final response = await http.post(
      Uri.parse(messageUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(reqBody),
    );
    return response;
  }

  static readMessage(token, messageId) async {
    final uri = '$messageUrl/$messageId';
    final response = await http.patch(
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

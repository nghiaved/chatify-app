import 'dart:convert';
import 'package:client/constants/app_colors.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/helpers/socket_io.dart';
import 'package:client/services/chat_service.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:client/widgets/item_chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.token});

  final String token;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List chats = [];
  Map<String, dynamic> userInfo = {};
  bool fetchAgain = false;

  @override
  void initState() {
    super.initState();
    fetchChats();
    userInfo = JwtDecoder.decode(widget.token);
    socket.emit('join-chat', 'all');
    socket.on('all', (data) {
      if (mounted) {
        setState(() {
          fetchAgain = data;
        });
      }
    });
  }

  fetchChats() async {
    final response = await ChatService.fetchChats(widget.token);
    setState(() {
      chats = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fetchAgain) {
      fetchChats();
      setState(() {
        fetchAgain = false;
      });
    }

    return chats.isEmpty
        ? Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetImages.logo,
                    scale: 2,
                    opacity: const AlwaysStoppedAnimation(.6),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "You haven't chat yet",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ButtonWidget(func: () {}, text: 'Start Chatting'),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColors.primaryColor,
              heroTag: 'chat',
              child: const Icon(Icons.sms, size: 28),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: chats.map(
                  (e) {
                    if (e['isGroupChat'] == false) {
                      userInfo['_id'] == e['users'][1]['_id']
                          ? e['user'] = e['users'][0]
                          : e['user'] = e['users'][1];
                      return ItemChatWidget(data: e, token: widget.token);
                    } else {
                      return const SizedBox();
                    }
                  },
                ).toList(),
              ),
            ),
          );
  }
}

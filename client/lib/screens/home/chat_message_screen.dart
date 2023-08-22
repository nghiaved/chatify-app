import 'dart:convert';
import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/constants/app_styles.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/services/message_service.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/icon_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ChatMessageScreen extends StatefulWidget {
  const ChatMessageScreen({
    super.key,
    required this.token,
    required this.chat,
  });

  final String token;
  final Map chat;

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _contentController = TextEditingController();
  List messages = [];
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    fetchMessages();
    userInfo = JwtDecoder.decode(widget.token);
  }

  fetchMessages() async {
    final response =
        await MessageService.fetchMessages(widget.token, widget.chat['_id']);
    setState(() {
      messages = jsonDecode(response.body);
    });
  }

  sendMessage() async {
    if (formKey.currentState!.validate()) {
      final reqBody = {
        "chatId": widget.chat['_id'],
        "content": _contentController.text,
      };

      await MessageService.sendMessage(widget.token, reqBody);
      _contentController.text = '';
      fetchMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        avatar: AssetImages.avatar,
        text: widget.chat['user']['name'],
        actions: [
          IconAppBarWidget(
            icon: Icons.more_vert,
            func: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: messages.map((e) {
                    return Container(
                      alignment: e['sender']['_id'] == userInfo['_id']
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                        bottom: AppDimensions.smallSpacing,
                      ),
                      child: Container(
                        padding:
                            const EdgeInsets.all(AppDimensions.mediumSpacing),
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(e['content']),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: AppDimensions.largeSpacing,
              ),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: _contentController,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  decoration: AppStyles.inputDecoration(
                    'Type message...',
                    null,
                  ).copyWith(
                    suffixIcon: IconButton(
                      splashRadius: AppDimensions.splashRadius,
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send),
                    ),
                    suffixIconColor: AppColors.primaryColor,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
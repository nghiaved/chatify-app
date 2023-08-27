import 'dart:io';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/helpers/socket_io.dart';
import 'package:client/screens/home/chat_message_screen.dart';
import 'package:client/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ItemChatWidget extends StatefulWidget {
  const ItemChatWidget({super.key, required this.data, required this.token});

  final Map data;
  final String token;

  @override
  State<ItemChatWidget> createState() => _ItemChatWidgetState();
}

class _ItemChatWidgetState extends State<ItemChatWidget> {
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    userInfo = JwtDecoder.decode(widget.token);
  }

  readMessage() async {
    await MessageService.readMessage(
        widget.token, widget.data['latestMessage']['_id']);
    socket.emit('all', true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.data['latestMessage']['readBy'].isEmpty &&
            widget.data['latestMessage']['sender']['_id'] != userInfo['_id']) {
          readMessage();
        }
        nextScreen(
          context,
          ChatMessageScreen(
            token: widget.token,
            chat: widget.data,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.largeSpacing,
        ),
        child: Row(
          children: [
            widget.data['user']['image'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.file(
                      File(widget.data['user']['image']),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    AssetImages.avatar,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(width: AppDimensions.mediumSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.data['user']['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('h:mm a').format(DateTime.parse(
                            widget.data['latestMessage']['updatedAt'])),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.smallSpacing),
                  Text(
                    widget.data['latestMessage'] != null
                        ? widget.data['latestMessage']['content']
                        : 'No messages yet',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: widget
                                  .data['latestMessage']['readBy'].isEmpty &&
                              widget.data['latestMessage']['sender']['_id'] !=
                                  userInfo['_id']
                          ? FontWeight.bold
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/constants/app_styles.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/helpers/socket_io.dart';
import 'package:client/screens/home/chat_message_screen.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/services/chat_service.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.token});

  final String token;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();
  List users = [];
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    super.initState();
    userInfo = JwtDecoder.decode(widget.token);
  }

  searchUser() async {
    if (_textController.text.isNotEmpty) {
      final response =
          await AuthService.searchUser(_textController.text, widget.token);
      final data = jsonDecode(response.body);
      if (data.length != 0) {
        setState(() {
          users = jsonDecode(response.body);
        });
      } else {
        setState(() {
          users = [];
        });
      }
    }
  }

  createChat(user) async {
    final response = await ChatService.createChat(user['_id'], widget.token);
    socket.emit('all', true);
    final data = jsonDecode(response.body);
    userInfo['_id'] == data['users'][1]['_id']
        ? data['user'] = data['users'][0]
        : data['user'] = data['users'][1];
    // ignore: use_build_context_synchronously
    nextScreen(
      context,
      ChatMessageScreen(
        token: widget.token,
        chat: data,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'Search'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _textController,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: AppStyles.inputDecoration(
                'Search user...',
                null,
              ).copyWith(
                suffixIcon: IconButton(
                  splashRadius: AppDimensions.splashRadius,
                  onPressed: searchUser,
                  icon: const Icon(
                    Icons.search,
                    size: AppDimensions.iconSize,
                  ),
                ),
                suffixIconColor: AppColors.primaryColor,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Column(
                      children: users.map((e) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                        bottom: AppDimensions.mediumSpacing,
                      ),
                      child: Row(children: [
                        e['image'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.file(
                                  File(e['image']),
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
                        const SizedBox(
                          width: AppDimensions.mediumSpacing,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: AppDimensions.smallSpacing,
                            ),
                            Text(e['email']),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          splashRadius: AppDimensions.splashRadius,
                          onPressed: () {
                            createChat(e);
                          },
                          icon: const Icon(
                            Icons.sms,
                            size: AppDimensions.iconSize,
                          ),
                        ),
                      ]),
                    );
                  }).toList()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

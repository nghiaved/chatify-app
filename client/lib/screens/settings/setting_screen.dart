import 'dart:io';

import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/screens/settings/account_screen.dart';
import 'package:client/screens/settings/help_screen.dart';
import 'package:client/screens/settings/profile_screen.dart';
import 'package:client/screens/auth/signin_screen.dart';
import 'package:client/screens/settings/security_screen.dart';
import 'package:client/screens/settings/notification_screen.dart';
import 'package:client/screens/settings/chat_setting_screen.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:client/widgets/item_setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key, required this.userInfo});

  final Map<String, dynamic> userInfo;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'Settings',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  nextScreen(context, ProfileScreen(userInfo: widget.userInfo));
                },
                child: Row(
                  children: [
                    Stack(
                      children: [
                        widget.userInfo['image'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Image.file(
                                  File(widget.userInfo['image']),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                AssetImages.avatar,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                        Positioned(
                          bottom: 4,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppColors.primaryColor,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 12,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppDimensions.mediumSpacing),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userInfo['name'] ??
                              getNameInEmail(widget.userInfo['email']),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.smallSpacing),
                        Text(
                          widget.userInfo['email'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.smallSpacing),
                        const Text(
                          'Available',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ItemSettingWidget(
                icon: Icons.person,
                text: 'Account',
                func: () {
                  nextScreen(context, const AccountScreen());
                },
              ),
              ItemSettingWidget(
                icon: Icons.mode_comment,
                text: 'Chats',
                func: () {
                  nextScreen(context, const ChatSettingScreen());
                },
              ),
              ItemSettingWidget(
                icon: Icons.notifications,
                text: 'Notifications',
                func: () {
                  nextScreen(context, const NotificationScreen());
                },
              ),
              ItemSettingWidget(
                icon: Icons.verified_user,
                text: 'Security',
                func: () {
                  nextScreen(context, const SecurityScreen());
                },
              ),
              ItemSettingWidget(
                icon: Icons.info,
                text: 'Help',
                func: () {
                  nextScreen(context, const HelpScreen());
                },
              ),
              _isLoading
                  ? Column(
                      children: const [
                        DashlineWidget(),
                        SizedBox(height: AppDimensions.largeSpacing),
                        CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ],
                    )
                  : ItemSettingWidget(
                      icon: Icons.logout,
                      text: 'Logout',
                      isLogout: true,
                      func: () {
                        showModalBottom(
                          context,
                          title: 'Are You Sure You Want to Logout?',
                          yes: 'Yes, Logout',
                          no: 'Cancel',
                          func: () async {
                            Navigator.of(context).pop();
                            setState(() {
                              _isLoading = true;
                            });
                            await Future.delayed(const Duration(seconds: 1));
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('token');
                            // ignore: use_build_context_synchronously
                            nextScreen(context, const SigninScreen());
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

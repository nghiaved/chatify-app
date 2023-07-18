import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:client/widgets/item_setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLoading = false;

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
              Row(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        AssetImages.avatar,
                        width: 80,
                        height: 80,
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
                    children: const [
                      Text(
                        'Ali Mustafa',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: AppDimensions.smallSpacing),
                      Text(
                        '+92 309-0167993',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: AppDimensions.smallSpacing),
                      Text(
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
              const ItemSettingWidget(icon: Icons.person, text: 'Account'),
              const ItemSettingWidget(icon: Icons.mode_comment, text: 'Chats'),
              const ItemSettingWidget(
                icon: Icons.notifications,
                text: 'Notifications',
              ),
              const ItemSettingWidget(
                icon: Icons.verified_user,
                text: 'Security',
              ),
              ItemSettingWidget(
                icon: Icons.info,
                text: 'Help',
                func: () {},
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

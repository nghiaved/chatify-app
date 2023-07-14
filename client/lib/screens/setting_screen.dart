import 'package:client/helpers/asset_images.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: 'Settings',
        avatar: AssetImages.avatar,
        actions: [
          const IconWidget(
            icon: Icons.phone_outlined,
          ),
          const IconWidget(
            icon: Icons.video_call_outlined,
          ),
          IconWidget(
            icon: Icons.more_vert,
            func: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                // ignore: use_build_context_synchronously
                nextScreen(context, const SigninScreen());
              },
              child: const Text('Settings'),
            ),
          ),
        ),
      ),
    );
  }
}

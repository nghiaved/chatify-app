import 'package:client/constants/app_colors.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "You haven't Groups yet",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 40),
            ButtonWidget(func: () {}, text: 'Create Group'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor,
        heroTag: 'group',
        child: const Icon(Icons.sms, size: 28),
      ),
    );
  }
}

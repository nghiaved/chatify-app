import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/constants/app_styles.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text(
                                'Change Avatar',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: AppDimensions.mediumSpacing * 2,
                              ),
                              buildItemChangAvatar(
                                Icons.camera_alt_outlined,
                                'Take Photo',
                              ),
                              const SizedBox(
                                height: AppDimensions.largeSpacing,
                              ),
                              buildItemChangAvatar(
                                Icons.shopping_bag_outlined,
                                'From Gallery',
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.largeSpacing,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          AppDimensions.smallSpacing,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Image.asset(
                          AssetImages.avatar,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(
                            AppDimensions.smallSpacing,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.primaryColor,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              buildItemInfo(
                title: 'Name',
                content: 'Ali Mustafa',
                isRequired: true,
              ),
              const SizedBox(
                height: AppDimensions.mediumSpacing,
              ),
              buildItemInfo(
                title: 'Email',
                content: 'nghia@gmail.com',
                isRequired: true,
              ),
              const SizedBox(
                height: AppDimensions.mediumSpacing,
              ),
              buildItemInfo(
                title: 'About',
                content: 'Available',
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(
                  top: AppDimensions.largeSpacing,
                  left: AppDimensions.largeSpacing,
                ),
                child: ButtonWidget(func: () {}, text: 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildItemChangAvatar(IconData icon, String text) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(1, 2),
              blurRadius: 3,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Icon(
                icon,
                size: AppDimensions.iconSize,
              ),
            ),
            const SizedBox(
              height: AppDimensions.mediumSpacing,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildItemInfo({
    required String title,
    required String content,
    bool? isRequired,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.mediumSpacing,
          ),
          child: Text.rich(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            TextSpan(
              text: title,
              children: [
                isRequired != null
                    ? const TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: AppColors.redColor,
                        ),
                      )
                    : const TextSpan(),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.smallSpacing),
        TextFormField(
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          decoration: AppStyles.inputDecoration(content, null),
        ),
      ],
    );
  }
}

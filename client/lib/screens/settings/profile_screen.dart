import 'dart:convert';
import 'dart:io';
import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/constants/app_styles.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/screens/auth/signin_screen.dart';
import 'package:client/widgets/item_change_avatar_widget.dart';
import 'package:client/screens/settings/qr_code_screen.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:client/widgets/item_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.userInfo});

  final Map<String, dynamic> userInfo;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool isImageSelected = false;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.userInfo['name'] ?? getNameInEmail(widget.userInfo['email']),
    );
    _emailController = TextEditingController(text: widget.userInfo['email']);
    super.initState();
  }

  update() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = !_isLoading;
      });

      await Future.delayed(const Duration(seconds: 1));

      final reqBody = {
        "name": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        'image': widget.userInfo['image'] ?? ''
      };

      try {
        final response =
            await AuthService.updateUser(widget.userInfo['_id'], reqBody);
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status']) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('token');
          // ignore: use_build_context_synchronously
          nextScreen(context, const SigninScreen());
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, AppColors.redColor, 'Update profile failure');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<XFile?> imageFile;
    ImagePicker picker = ImagePicker();

    return Scaffold(
      appBar: AppBarWidget(
        text: 'Profile',
        actions: [
          IconButton(
            splashRadius: AppDimensions.splashRadius,
            icon: const Icon(
              Icons.share,
              size: AppDimensions.iconSize,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              nextScreen(context, QRCodeScreen(userInfo: widget.userInfo));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
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
                                ItemChangeAvatarWidget(
                                  icon: Icons.camera_alt_outlined,
                                  text: 'Take Photo',
                                  func: () {
                                    imageFile = picker.pickImage(
                                        source: ImageSource.camera);
                                    imageFile.then((file) async {
                                      setState(
                                        () {
                                          widget.userInfo['image'] = file?.path;
                                          isImageSelected = true;
                                        },
                                      );
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(
                                  height: AppDimensions.largeSpacing,
                                ),
                                ItemChangeAvatarWidget(
                                  icon: Icons.shopping_bag_outlined,
                                  text: 'From Gallery',
                                  func: () {
                                    imageFile = picker.pickImage(
                                        source: ImageSource.gallery);
                                    imageFile.then((file) async {
                                      setState(
                                        () {
                                          widget.userInfo['image'] = file?.path;
                                          isImageSelected = true;
                                        },
                                      );
                                    });
                                    Navigator.pop(context);
                                  },
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
                          child: widget.userInfo['image'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.file(
                                    File(widget.userInfo['image']),
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
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
                ItemInfoWidget(
                  title: 'Name',
                  child: TextFormField(
                    controller: _nameController,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    decoration: AppStyles.inputDecoration(
                        widget.userInfo['name'] ??
                            getNameInEmail(widget.userInfo['email']),
                        null),
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.mediumSpacing,
                ),
                ItemInfoWidget(
                  title: 'Email',
                  isRequired: true,
                  child: TextFormField(
                    controller: _emailController,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    decoration: AppStyles.inputDecoration(
                        widget.userInfo['email'], null),
                    validator: (value) {
                      return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value!)
                          ? null
                          : "Please enter a valid email";
                    },
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.mediumSpacing,
                ),
                ItemInfoWidget(
                  title: 'Password',
                  isRequired: true,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    decoration: AppStyles.inputDecoration('******', null),
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Password must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    top: AppDimensions.largeSpacing,
                    left: AppDimensions.largeSpacing,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : ButtonWidget(func: update, text: 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

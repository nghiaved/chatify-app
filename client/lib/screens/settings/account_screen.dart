import 'dart:convert';

import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/screens/auth/signin_screen.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:client/widgets/item_text_show_widget.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.id});

  final String id;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isLoading = false;

  void deleteUser() async {
    final response = await AuthService.deleteUser(widget.id);
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // ignore: use_build_context_synchronously
      nextScreen(context, const SigninScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'Account',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const ItemTextShowWidget(text: 'Privacy'),
            const DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            const ItemTextShowWidget(text: 'Change Email'),
            const DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            const ItemTextShowWidget(text: 'Request Account info'),
            const DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
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
                : ItemTextShowWidget(
                    text: 'Delete My Account',
                    isDelete: true,
                    func: () {
                      showModalBottom(
                        context,
                        title: 'Are You Sure You Want to Delete the Account?',
                        yes: 'Yes, Delete',
                        no: 'Cancel',
                        func: () async {
                          Navigator.of(context).pop();
                          setState(() {
                            _isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 1));
                          deleteUser();
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

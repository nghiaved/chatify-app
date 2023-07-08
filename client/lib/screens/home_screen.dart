import 'package:client/helpers/helper_function.dart';
import 'package:client/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.token});

  final String? token;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = JwtDecoder.decode(widget.token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Text(userInfo['email']),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('token');
                  // ignore: use_build_context_synchronously
                  nextScreen(context, const SigninScreen());
                },
                child: const Text('Log out'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

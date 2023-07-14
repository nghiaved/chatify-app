import 'package:client/constants/app_colors.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/screens/call_screen.dart';
import 'package:client/screens/chat_screen.dart';
import 'package:client/screens/group_screen.dart';
import 'package:client/screens/setting_screen.dart';
import 'package:client/screens/status_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.token});

  final String? token;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> userInfo;
  int _currentIndex = 0;
  List<Map> headerData = [
    {
      'name': 'Chats',
    },
    {
      'name': 'Groups',
    },
    {
      'name': 'Status',
    },
    {
      'name': 'Calls',
    },
  ];

  @override
  void initState() {
    super.initState();
    userInfo = JwtDecoder.decode(widget.token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Chatify',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search, size: 24),
                          splashRadius: 20,
                          onPressed: () {
                            // ignore: avoid_print
                            print('Search screen');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert, size: 24),
                          splashRadius: 20,
                          onPressed: () {
                            nextScreen(
                              context,
                              const SettingScreen(),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: headerData
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = headerData.indexOf(e);
                            });
                          },
                          child: buildIndicator(
                              headerData.indexOf(e) == _currentIndex, e),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: const [
                    ChatScreen(),
                    GroupScreen(),
                    StatusScreen(),
                    CallScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Map e) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 4),
          width: 60,
          child: Text(
            e['name'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? AppColors.primaryColor : AppColors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        isActive
            ? Container(
                width: 60,
                height: 4,
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(2, 3),
                        blurRadius: 3,
                      ),
                    ]),
              )
            : const SizedBox()
      ],
    );
  }
}

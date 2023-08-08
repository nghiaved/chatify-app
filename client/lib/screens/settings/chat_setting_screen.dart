import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:client/widgets/item_text_switch_widget.dart';
import 'package:flutter/material.dart';

class ChatSettingScreen extends StatefulWidget {
  const ChatSettingScreen({super.key});

  @override
  State<ChatSettingScreen> createState() => _ChatSettingScreenState();
}

class _ChatSettingScreenState extends State<ChatSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'Chats'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ItemTextSwitchWidget(text: 'Separate Groups', switchValue: true),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Enter is Send'),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Media Visibility', switchValue: true),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Backup Chat Regularly'),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Keep Chats Archived'),
          ],
        ),
      ),
    );
  }
}

import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:client/widgets/item_text_switch_widget.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'Notifications'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ItemTextSwitchWidget(text: 'Conversation tones', switchValue: true),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Sound', switchValue: true),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Vibrate'),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'New Tips Available'),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'New Update Available'),
          ],
        ),
      ),
    );
  }
}

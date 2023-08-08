import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:client/widgets/item_text_switch_widget.dart';
import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'Security'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ItemTextSwitchWidget(text: 'Two-Step Verification'),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Face ID', switchValue: true),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Remember me'),
            DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextSwitchWidget(text: 'Touch ID'),
          ],
        ),
      ),
    );
  }
}

import 'package:client/helpers/helper_function.dart';
import 'package:client/screens/lorem_screen.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:client/widgets/item_text_show_widget.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        text: 'Help',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const ItemTextShowWidget(text: 'FAQ'),
            const DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextShowWidget(
              text: 'Term & Conditions',
              func: () {
                nextScreen(
                  context,
                  const LoremScreen(
                    title: 'Terms & Conditions',
                  ),
                );
              },
            ),
            const DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            ItemTextShowWidget(
              text: 'Privacy Policy',
              func: () {
                nextScreen(
                  context,
                  const LoremScreen(
                    title: 'Privacy Policy',
                  ),
                );
              },
            ),
            const DashlineWidget(margin: EdgeInsets.symmetric(vertical: 10)),
            const ItemTextShowWidget(text: 'App Info'),
          ],
        ),
      ),
    );
  }
}

import 'package:client/constants/app_dimensions.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:client/widgets/item_faq_widget.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'FAQ'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            ItemFAQWidget(
              text: 'What is Chatify?',
              subText: 'Chatify is greatest chatting platform of this century.',
            ),
            SizedBox(height: AppDimensions.largeSpacing),
            ItemFAQWidget(
              text: 'Is Chatify is safe for me?',
            ),
            SizedBox(height: AppDimensions.largeSpacing),
            ItemFAQWidget(
              text: 'How to send Messages on Chatify?',
            ),
            SizedBox(height: AppDimensions.largeSpacing),
            ItemFAQWidget(
              text: 'Is Chatify free to use ?',
            ),
          ],
        ),
      ),
    );
  }
}

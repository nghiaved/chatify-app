import 'package:client/constants/app_dimensions.dart';
import 'package:client/widgets/button_widget.dart';
import 'package:flutter/material.dart';

void nextScreen(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: const TextStyle(fontSize: 14)),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ),
  );
}

Future<dynamic> showModalBottom(
  BuildContext context, {
  required String title,
  required String yes,
  required String no,
  required Function() func,
}) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppDimensions.largeSpacing,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: AppDimensions.largeSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 160,
                  child: ButtonWidget(
                    func: () => Navigator.pop(context),
                    text: no,
                    isCancel: true,
                  ),
                ),
                const SizedBox(
                  width: AppDimensions.largeSpacing,
                ),
                SizedBox(
                  width: 160,
                  child: ButtonWidget(
                    func: func,
                    text: yes,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

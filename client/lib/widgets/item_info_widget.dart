import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

class ItemInfoWidget extends StatelessWidget {
  const ItemInfoWidget(
      {super.key, required this.child, required this.title, this.isRequired});

  final Widget child;
  final String title;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimensions.mediumSpacing,
          ),
          child: Text.rich(
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            TextSpan(
              text: title,
              children: [
                isRequired != null
                    ? const TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: AppColors.redColor,
                        ),
                      )
                    : const TextSpan(),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.smallSpacing),
        child,
      ],
    );
  }
}

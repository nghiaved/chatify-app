import 'package:client/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DashlineWidget extends StatelessWidget {
  const DashlineWidget({super.key, this.margin});

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyColor, width: 2),
        ),
      ),
    );
  }
}

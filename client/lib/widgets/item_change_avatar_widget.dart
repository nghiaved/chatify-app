import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

class ItemChangeAvatarWidget extends StatelessWidget {
  const ItemChangeAvatarWidget(
      {super.key, required this.func, required this.icon, required this.text});

  final Function() func;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(1, 2),
              blurRadius: 3,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: func,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                child: Icon(
                  icon,
                  size: AppDimensions.iconSize,
                ),
              ),
              const SizedBox(
                height: AppDimensions.mediumSpacing,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

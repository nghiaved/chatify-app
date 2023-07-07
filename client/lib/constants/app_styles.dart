import 'package:client/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static InputDecoration inputDecoration(text, IconData? icon) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(20),
      isDense: true,
      hintText: text,
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: Icon(
          icon,
          color: AppColors.blackColor,
          size: 26,
        ),
      ),
      border: InputBorder.none,
      filled: true,
      fillColor: AppColors.greyColor,
      hoverColor: AppColors.greyColor,
      focusColor: AppColors.greyColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(40),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(40),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}

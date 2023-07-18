import 'package:client/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget(
      {super.key, required this.func, required this.text, this.isCancel});

  final Function() func;
  final String text;
  final bool? isCancel;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.func,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isCancel == null
            ? AppColors.primaryColor
            : AppColors.whiteColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: const BorderSide(
            color: AppColors.primaryColor,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.isCancel == null
                ? AppColors.whiteColor
                : AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

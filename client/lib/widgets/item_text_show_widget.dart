import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

class ItemTextShowWidget extends StatelessWidget {
  const ItemTextShowWidget({
    super.key,
    required this.text,
    this.isDelete,
    this.func,
  });

  final String text;
  final bool? isDelete;
  final Function()? func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: isDelete == null
                ? const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                  )
                : const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.redColor,
                  ),
          ),
          const Icon(
            Icons.keyboard_arrow_right,
            size: AppDimensions.iconSize,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

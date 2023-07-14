import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

final appBarHeight = AppBar().preferredSize.height;

class IconWidget extends StatefulWidget {
  const IconWidget({super.key, this.func, required this.icon});

  final Function()? func;
  final IconData icon;

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: appBarHeight - AppDimensions.largeSpacing,
      height: appBarHeight - AppDimensions.largeSpacing,
      margin: const EdgeInsets.only(
        left: AppDimensions.smallSpacing,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: GestureDetector(
        onTap: widget.func ?? () {},
        child: Icon(
          widget.icon,
          color: AppColors.primaryColor,
          size: AppDimensions.iconSize,
        ),
      ),
    );
  }
}

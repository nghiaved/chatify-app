import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:flutter/material.dart';

class ItemSettingWidget extends StatelessWidget {
  const ItemSettingWidget({
    super.key,
    required this.icon,
    required this.text,
    this.func,
    this.isLogout,
  });

  final IconData icon;
  final String text;
  final Function()? func;
  final bool? isLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DashlineWidget(
          margin: EdgeInsets.symmetric(
            vertical: AppDimensions.mediumSpacing,
          ),
        ),
        GestureDetector(
          onTap: func ?? () {},
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (isLogout == null)
                      ? AppColors.secondColor
                      : const Color(0xffffe8ed),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: (isLogout == null)
                      ? AppColors.primaryColor
                      : AppColors.redColor,
                  size: AppDimensions.iconSize,
                ),
              ),
              const SizedBox(width: AppDimensions.mediumSpacing),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              if (isLogout == null) const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/widgets/dashline_widget.dart';
import 'package:flutter/material.dart';

class ItemFAQWidget extends StatefulWidget {
  const ItemFAQWidget({
    super.key,
    required this.text,
    this.subText,
  });

  final String text;
  final String? subText;

  @override
  State<ItemFAQWidget> createState() => _ItemFAQWidgetState();
}

class _ItemFAQWidgetState extends State<ItemFAQWidget> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isShow = !isShow;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.largeSpacing,
            vertical: AppDimensions.largeSpacing - AppDimensions.mediumSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    !isShow
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: AppColors.primaryColor,
                    size: AppDimensions.iconSize,
                  ),
                ],
              ),
              isShow
                  ? const DashlineWidget(
                      margin: EdgeInsets.symmetric(
                        vertical: AppDimensions.mediumSpacing,
                      ),
                    )
                  : const SizedBox(),
              isShow
                  ? Text(
                      widget.subText != null
                          ? widget.subText!
                          : 'No answer found',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

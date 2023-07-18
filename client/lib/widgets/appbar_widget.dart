import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

final appBarHeight = AppBar().preferredSize.height;

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, this.text, this.avatar, this.actions});

  final String? text;
  final String? avatar;
  final List<Widget>? actions;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: appBarHeight,
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.mediumSpacing,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.greyColor, width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  splashRadius: AppDimensions.splashRadius,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryColor,
                    size: AppDimensions.iconSize,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                widget.avatar != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: AppDimensions.smallSpacing,
                        ),
                        child: Image.asset(
                          widget.avatar!,
                          width: appBarHeight - AppDimensions.mediumSpacing,
                          height: appBarHeight - AppDimensions.mediumSpacing,
                        ),
                      )
                    : const SizedBox(),
                widget.text != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: AppDimensions.smallSpacing,
                        ),
                        child: Text(
                          widget.text!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              children: widget.actions != null
                  ? widget.actions!.map((item) {
                      return item;
                    }).toList()
                  : [],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:client/constants/app_colors.dart';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:client/helpers/helper_function.dart';
import 'package:client/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key, required this.userInfo});

  final Map<String, dynamic> userInfo;

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  bool _changeCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(text: 'QR Code'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _changeCode == false
                ? Column(
                    children: [
                      Image.asset(
                        AssetImages.avatar,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: AppDimensions.mediumSpacing),
                      Text(
                        widget.userInfo['name'] ??
                            getNameInEmail(widget.userInfo['email']),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.smallSpacing),
                      Text(
                        widget.userInfo['email'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.largeSpacing),
                    ],
                  )
                : const SizedBox(),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _changeCode = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: _changeCode == false ? 3 : 1,
                            color: _changeCode == false
                                ? AppColors.primaryColor
                                : AppColors.blackColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.smallSpacing,
                        ),
                        child: Text(
                          'My Code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _changeCode == false
                                ? AppColors.primaryColor
                                : AppColors.blackColor.withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _changeCode = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: _changeCode == true ? 3 : 1,
                            color: _changeCode == true
                                ? AppColors.primaryColor
                                : AppColors.blackColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.smallSpacing,
                        ),
                        child: Text(
                          'Scan Code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _changeCode == true
                                ? AppColors.primaryColor
                                : AppColors.blackColor.withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.largeSpacing),
            _changeCode == false ? const SizedBox() : const Spacer(),
            Image.asset(
              _changeCode == false ? AssetImages.myCode : AssetImages.scanCode,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            _changeCode == false ? const SizedBox() : const Spacer(),
            const SizedBox(height: AppDimensions.largeSpacing),
            _changeCode == false
                ? const Text(
                    'Your QR Code is private. If you share it with someone, then they can add you as a contact.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

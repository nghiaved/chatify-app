import 'dart:io';
import 'package:client/constants/app_dimensions.dart';
import 'package:client/helpers/asset_images.dart';
import 'package:flutter/material.dart';

class ItemChatWidget extends StatelessWidget {
  const ItemChatWidget({super.key, required this.data});

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppDimensions.largeSpacing,
      ),
      child: Row(
        children: [
          data['user']['image'] != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.file(
                    File(data['user']['image']),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  AssetImages.avatar,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
          const SizedBox(width: AppDimensions.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['user']['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      '10:43 AM',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.smallSpacing),
                const Text(
                  'Latest chat message',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

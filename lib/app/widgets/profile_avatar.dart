import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String photoBase64;
  final Uint8List? bytes;
  final double size;
  final bool showCamera;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    this.photoBase64 = '',
    this.bytes,
    this.size = 64,
    this.showCamera = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;
    if (bytes != null) {
      provider = MemoryImage(bytes!);
    } else if (photoBase64.isNotEmpty) {
      provider = MemoryImage(base64Decode(photoBase64));
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            Container(
              width: size,
              height: size,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: ClipOval(
                child: provider != null
                    ? Image(
                        image: provider,
                        fit: BoxFit.cover,
                        width: size,
                        height: size)
                    : Container(
                        color: Colors.grey.shade300,
                        child: Icon(Icons.person,
                            size: size * 0.55, color: Colors.grey),
                      ),
              ),
            ),
            if (showCamera)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Icon(Icons.camera_alt,
                      size: 12, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
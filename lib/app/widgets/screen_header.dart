import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_colors.dart';

/// Back button + center title (Categories, Pizza, Cart screens)
class ScreenHeader extends StatelessWidget {
  final String title;
  const ScreenHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.chevron_left,
                color: AppColors.primary, size: 22),
          ),
        ),
        Expanded(
          child: Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(width: 34), // title ko center rakhne ke liye
      ],
    );
  }
}
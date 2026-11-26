import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../widgets/profile_avatar.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final String country;
  final String photoBase64;

  const HomeHeader({
    super.key,
    required this.name,
    required this.country,
    this.photoBase64 = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(photoBase64: photoBase64, size: 46),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent)),
              Text(country,
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: AppColors.textGrey)),
            ],
          ),
        ),
        const Icon(Icons.notifications, color: Colors.black, size: 26),
      ],
    );
  }
}
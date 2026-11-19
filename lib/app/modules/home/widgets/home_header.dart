import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final String country;
  const HomeHeader({super.key, required this.name, required this.country});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(AppAssets.profile,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                  width: 44,
                  height: 44,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.grey))),
        ),
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

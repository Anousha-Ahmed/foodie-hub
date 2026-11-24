import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showArrow;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textDark),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title,
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark)),
            ),
            if (showArrow)
              const Icon(Icons.chevron_right,
                  size: 20, color: AppColors.textDark),
          ],
        ),
      ),
    );
  }
}
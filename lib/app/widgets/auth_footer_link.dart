import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_colors.dart';

/// "Don't have an account? Sign up" type bottom text
class AuthFooterLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;

  const AuthFooterLink(
      {super.key,
      required this.text,
      required this.linkText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
            style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textDark)),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onTap,
          child: Text(linkText,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary)),
        ),
      ],
    );
  }
}

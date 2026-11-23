import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/payment_method_model.dart';

class PaymentOptionTile extends StatelessWidget {
  final PaymentMethodModel method;
  final String? title; 
  final bool selected;
  final VoidCallback onTap;

  const PaymentOptionTile({
    super.key,
    required this.method,
    this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Image.asset(method.asset,
                width: 20,
                height: 20,
                errorBuilder: (_, __, ___) => Icon(method.fallbackIcon,
                    size: 22, color: method.fallbackColor)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(title ?? method.name,
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: AppColors.textGrey)),
            ),
            if (selected)
              const Icon(Icons.check_circle,
                  size: 18, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
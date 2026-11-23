import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../widgets/bottom_action_bar.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // back button se wapas payment screen par na ja sake
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Figma se confetti image export karke is naam se rakhein
                        Image.asset(
                          'assets/images/payment_success.png',
                          height: 190,
                          errorBuilder: (_, __, ___) => const Icon(
                              Icons.celebration_rounded,
                              size: 110,
                              color: AppColors.accent),
                        ),
                        const SizedBox(height: 28),
                        Text('Congratulations!',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1B1B3A))),
                        const SizedBox(height: 12),
                        Text(
                          'You successfully made a payment,\nenjoy our service!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              height: 1.5,
                              color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BottomActionBar(
                buttonText: 'Back To Home',
                onPressed: () => Get.offAllNamed(AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
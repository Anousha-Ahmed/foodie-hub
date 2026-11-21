import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/screen_header.dart';
import '../checkout/checkout_controller.dart';
import 'widgets/summary_row.dart';

class OrderSummaryScreen extends GetView<CheckoutController> {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ScreenHeader(title: 'Order Summary'),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: AppColors.textDark),
                      children: [
                        const TextSpan(text: 'Order ID '),
                        TextSpan(
                            text: '#${controller.orderId}',
                            style: const TextStyle(color: AppColors.accent)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final c in controller.cart.items) ...[
                    SummaryRow(
                      title: '${c.item.name} (${c.quantity.value})',
                      amount: Formatters.price(c.total),
                    ),
                    const SizedBox(height: 10),
                  ],
                  SummaryRow(
                    title: 'Delivery Charges',
                    amount: Formatters.price(controller.deliveryCharges),
                  ),
                ],
              ),
            ),
            BottomActionBar(
              totalText: Formatters.price(controller.total),
              buttonText: 'Continue',
              onPressed: controller.goToAddress,
            ),
          ],
        ),
      ),
    );
  }
}
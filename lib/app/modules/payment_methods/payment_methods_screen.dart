import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/screen_header.dart';
import '../checkout/checkout_controller.dart';
import 'widgets/payment_option_tile.dart';

class PaymentMethodsScreen extends GetView<CheckoutController> {
  const PaymentMethodsScreen({super.key});

  Widget _title(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text,
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark)),
      );

  BoxDecoration get _boxDecoration => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ScreenHeader(title: 'Payment Methods'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  final selectedId = controller.selectedMethod.value?.id;
                  final last4 = controller.savedCardLast4.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('Credit & Debit Card'),
                      Container(
                        decoration: _boxDecoration,
                        child: Column(
                          children: [
                            for (final m in controller.cardMethods)
                              PaymentOptionTile(
                                method: m,
                                title: last4 == null
                                    ? m.name
                                    : '•••• •••• •••• $last4',
                                selected: selectedId == m.id,
                                onTap: controller.onCardTap,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      _title('More Payment Options'),
                      Container(
                        decoration: _boxDecoration,
                        child: Column(
                          children: [
                            for (var i = 0;
                                i < controller.otherMethods.length;
                                i++) ...[
                              PaymentOptionTile(
                                method: controller.otherMethods[i],
                                selected:
                                    selectedId == controller.otherMethods[i].id,
                                onTap: () => controller
                                    .selectMethod(controller.otherMethods[i]),
                              ),
                              if (i != controller.otherMethods.length - 1)
                                Divider(
                                    height: 1, color: Colors.grey.shade200),
                            ],
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            Obx(() => BottomActionBar(
                  buttonText: 'Pay & Confirm',
                  isLoading: controller.isLoading.value,
                  onPressed: controller.payAndConfirm,
                )),
          ],
        ),
      ),
    );
  }
}
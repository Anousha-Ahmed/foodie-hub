import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/input_formatters.dart';
import '../../core/utils/validators.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/custom_text_field.dart';
import '../checkout/checkout_controller.dart';

class AddCardScreen extends GetView<CheckoutController> {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // X button + title (Figma jaisa)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                          color: Color(0xFFECF0F4), shape: BoxShape.circle),
                      child: const Icon(Icons.close,
                          size: 18, color: AppColors.textDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Add Card',
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: AppColors.textDark)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                child: Form(
                  key: controller.cardFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Card Holder Name',
                        hint: 'Enter Name',
                        controller: controller.cardHolderController,
                        validator: (v) =>
                            Validators.required(v, 'Card holder name'),
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'Card Number',
                        hint: '1253 ____ ____ ____',
                        controller: controller.cardNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CardNumberFormatter()],
                        validator: Validators.cardNumber,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'Expire Date',
                              hint: 'mm/yyyy',
                              controller: controller.expiryController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [ExpiryDateFormatter()],
                              validator: Validators.expiry,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomTextField(
                              label: 'CVV',
                              hint: '***',
                              controller: controller.cvvController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              validator: Validators.cvv,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomActionBar(
              buttonText: 'Add New Card',
              onPressed: controller.addCard,
            ),
          ],
        ),
      ),
    );
  }
}
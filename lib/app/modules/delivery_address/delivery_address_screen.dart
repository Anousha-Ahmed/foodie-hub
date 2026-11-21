import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/validators.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_header.dart';
import '../checkout/checkout_controller.dart';

class DeliveryAddressScreen extends GetView<CheckoutController> {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ScreenHeader(title: 'Add Delivery Address'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                child: Form(
                  key: controller.addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Add Delivery Address',
                        hint: 'Enter your delivery address',
                        controller: controller.addressController,
                        maxLines: 3,
                        validator: (v) =>
                            Validators.required(v, 'Delivery address'),
                      ),
                      const SizedBox(height: 22),
                      CustomTextField(
                        label: 'Delivery Instructions',
                        hint: 'Write any instructions for the rider',
                        controller: controller.instructionsController,
                        maxLines: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomActionBar(
              buttonText: 'Continue',
              onPressed: controller.goToPayment,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/screen_header.dart';
import 'cart_controller.dart';
import 'widgets/cart_item_tile.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ScreenHeader(title: 'Cart'),
            ),
            Expanded(
              child: Obx(() {
                if (controller.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.shopping_cart_outlined,
                            size: 60, color: AppColors.textGrey),
                        const SizedBox(height: 10),
                        Text('Your cart is empty',
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: AppColors.textGrey)),
                        const SizedBox(height: 10),
                        _addMoreFood(),
                      ],
                    ),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    for (final c in controller.items) ...[
                      CartItemTile(cartItem: c, controller: controller),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 12),
                    Center(child: _addMoreFood()),
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
              child: CustomButton(
                text: 'Proceed to Order',
                onPressed: controller.proceedToOrder,
              ),
            ),
            CustomBottomNav(
              currentIndex: 1,
              onTap: (i) {
                if (i == 0) {
                  Get.offAllNamed(AppRoutes.home);
                } else if (i == 2) {
                  Get.snackbar('Profile', 'Coming soon',
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _addMoreFood() {
    return GestureDetector(
      onTap: () => Get.offAllNamed(AppRoutes.home),
      child: Text('Add More Food',
          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textDark)),
    );
  }
}
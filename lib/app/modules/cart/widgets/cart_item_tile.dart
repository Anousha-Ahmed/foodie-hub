import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../widgets/quantity_stepper.dart';
import '../cart_controller.dart';

class CartItemTile extends StatelessWidget {
  final CartItemModel cartItem;
  final CartController controller;
  const CartItemTile(
      {super.key, required this.cartItem, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(cartItem.item.image,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    width: 64,
                    height: 64,
                    color: Colors.orange.shade100,
                    child: const Icon(Icons.fastfood, color: Colors.orange))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 64,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(cartItem.item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textDark)),
                      ),
                      GestureDetector(
                        onTap: () => controller.remove(cartItem),
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(Icons.delete_outline,
                              size: 14, color: Colors.red.shade400),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text('Rs ${cartItem.total}',
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1565C0)))),
                      Obx(() => QuantityStepper(
                            quantity: cartItem.quantity.value,
                            onMinus: () => controller.decrement(cartItem),
                            onPlus: () => controller.increment(cartItem),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_search_field.dart';
import '../../widgets/quantity_stepper.dart';
import '../../widgets/screen_header.dart';
import '../home/widgets/food_card.dart';
import 'category_items_controller.dart';

class CategoryItemsScreen extends GetView<CategoryItemsController> {
  const CategoryItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ScreenHeader(title: controller.category.name),
                  const SizedBox(height: 16),
                  CustomSearchField(
                    hint: 'Search Your Favorite here',
                    controller: controller.searchController,
                    onChanged: controller.onSearch,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Obx(() => GridView.builder(
                          // panel dikhe to grid ke neeche jagah chhor do
                          padding: EdgeInsets.only(
                              bottom:
                                  controller.selected.value != null ? 190 : 16),
                          itemCount: controller.filtered.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 0.8,
                          ),
                          itemBuilder: (_, i) {
                            final item = controller.filtered[i];
                            return FoodCard(
                                item: item,
                                onAdd: () => controller.select(item));
                          },
                        )),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
                if (controller.selected.value == null) {
                  return const SizedBox.shrink();
                }
                return _AddToCartPanel(controller: controller);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddToCartPanel extends StatelessWidget {
  final CategoryItemsController controller;
  const _AddToCartPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      decoration: const BoxDecoration(
        color: Color(0xFFEFF3F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text('Rs ${controller.total}',
                  style: GoogleFonts.poppins(
                      fontSize: 22, color: AppColors.textDark))),
              Obx(() => QuantityStepper(
                    filled: true,
                    quantity: controller.quantity.value,
                    onMinus: controller.decrement,
                    onPlus: controller.increment,
                  )),
            ],
          ),
          const SizedBox(height: 18),
          CustomButton(
            text: 'ADD TO CART',
            height: 52,
            onPressed: controller.addToCart,
          ),
        ],
      ),
    );
  }
}
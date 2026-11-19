import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/custom_search_field.dart';
import 'categories_controller.dart';
import 'widgets/category_card.dart';

class CategoriesScreen extends GetView<CategoriesController> {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.primary, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.chevron_left,
                          color: AppColors.primary, size: 22),
                    ),
                  ),
                  Expanded(
                    child: Text('Categories',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(width: 34), // title ko center rakhne ke liye
                ],
              ),
              const SizedBox(height: 16),
              CustomSearchField(
                hint: 'Search Your Favorite here',
                controller: controller.searchController,
                onChanged: controller.onSearch,
              ),
              const SizedBox(height: 14),
              Expanded(
                child: Obx(() => GridView.builder(
                      itemCount: controller.filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.35,
                      ),
                      itemBuilder: (_, i) =>
                          CategoryCard(category: controller.filtered[i]),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
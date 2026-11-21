import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_search_field.dart';
import '../../widgets/screen_header.dart';
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
              const ScreenHeader(title: 'Categories'),
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
                      itemBuilder: (_, i) {
                        final c = controller.filtered[i];
                        return CategoryCard(
                            category: c,
                            onTap: () => controller.openCategory(c));
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
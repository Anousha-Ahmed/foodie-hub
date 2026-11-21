import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_assets.dart';
import '../../data/models/category_model.dart';
import '../../routes/app_routes.dart';

class CategoriesController extends GetxController {
  final searchController = TextEditingController();

  final _all = const <CategoryModel>[
    CategoryModel(name: 'Pizza', image: AppAssets.pizza),
    CategoryModel(name: 'Burger', image: AppAssets.burger),
    CategoryModel(name: 'Shawarma', image: AppAssets.shawarma),
    CategoryModel(name: 'Rolls', image: AppAssets.rolls),
    CategoryModel(name: 'Pizza', image: AppAssets.pizza),
    CategoryModel(name: 'Rolls', image: AppAssets.rolls),
    CategoryModel(name: 'Burger', image: AppAssets.burger),
    CategoryModel(name: 'Pizza', image: AppAssets.pizza),
  ];

  final filtered = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filtered.assignAll(_all);
  }

  void onSearch(String query) {
    final q = query.trim().toLowerCase();
    filtered.assignAll(
      q.isEmpty
          ? _all
          : _all.where((c) => c.name.toLowerCase().contains(q)).toList(),
    );
  }

  void openCategory(CategoryModel c) =>
      Get.toNamed(AppRoutes.categoryItems, arguments: c);

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
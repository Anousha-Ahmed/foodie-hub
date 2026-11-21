import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/category_model.dart';
import '../../data/models/food_item_model.dart';
import '../cart/cart_controller.dart';

class CategoryItemsController extends GetxController {
  final _cart = Get.find<CartController>();

  late final CategoryModel category;
  final searchController = TextEditingController();

  final _all = <FoodItemModel>[];
  final filtered = <FoodItemModel>[].obs;

  final selected = Rxn<FoodItemModel>();
  final quantity = 1.obs;

  static const _menu = {
    'Pizza': ('Peri Peri Pizza Small', 500),
    'Burger': ('Zinger Burger', 350),
    'Shawarma': ('Chicken Shawarma', 250),
    'Rolls': ('Spring Rolls', 300),
  };

  @override
  void onInit() {
    super.onInit();
    category = Get.arguments as CategoryModel;
    final data = _menu[category.name] ?? ('${category.name} Special', 400);
    _all.addAll(List.generate(
      6,
      (_) =>
          FoodItemModel(name: data.$1, image: category.image, price: data.$2),
    ));
    filtered.assignAll(_all);
  }

  void onSearch(String query) {
    final q = query.trim().toLowerCase();
    filtered.assignAll(q.isEmpty
        ? _all
        : _all.where((e) => e.name.toLowerCase().contains(q)).toList());
  }

  void select(FoodItemModel item) {
    selected.value = item;
    quantity.value = 1;
  }

  void increment() => quantity.value++;
  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }

  int get total => (selected.value?.price ?? 0) * quantity.value;

  void addToCart() {
    final item = selected.value;
    if (item == null) return;
    _cart.addItem(item, quantity: quantity.value);
    Get.snackbar('Added to cart', '${quantity.value} x ${item.name}',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2));
    selected.value = null;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
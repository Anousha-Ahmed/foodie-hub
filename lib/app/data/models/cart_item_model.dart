import 'package:get/get.dart';

import 'food_item_model.dart';

class CartItemModel {
  final FoodItemModel item;
  final RxInt quantity;

  CartItemModel({required this.item, int quantity = 1})
      : quantity = quantity.obs;

  int get total => item.price * quantity.value;
}
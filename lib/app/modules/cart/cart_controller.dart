import 'package:get/get.dart';

import '../../data/models/cart_item_model.dart';
import '../../data/models/food_item_model.dart';

class CartController extends GetxController {
  final items = <CartItemModel>[].obs;

  int get totalPrice => items.fold(0, (sum, e) => sum + e.total);

  void addItem(FoodItemModel item, {int quantity = 1}) {
    final i = items.indexWhere((e) => e.item.name == item.name);
    if (i >= 0) {
      items[i].quantity.value += quantity;
    } else {
      items.add(CartItemModel(item: item, quantity: quantity));
    }
  }

  void increment(CartItemModel c) => c.quantity.value++;

  void decrement(CartItemModel c) {
    if (c.quantity.value > 1) {
      c.quantity.value--;
    } else {
      remove(c);
    }
  }

  void remove(CartItemModel c) => items.remove(c);

  void proceedToOrder() {
    if (items.isEmpty) {
      Get.snackbar('Cart is empty', 'Please add some food first',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    Get.snackbar('Order', 'Total: Rs $totalPrice (checkout coming soon)',
        snackPosition: SnackPosition.BOTTOM);
  }
}
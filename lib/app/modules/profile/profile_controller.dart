import 'dart:async';

import 'package:get/get.dart';

import '../../data/models/food_item_model.dart';
import '../../data/models/order_model.dart';
import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/order_service.dart';
import '../../routes/app_routes.dart';
import '../cart/cart_controller.dart';

class ProfileController extends GetxController {
  final _auth = AuthService();
  final _orderService = OrderService();
  final _cart = Get.find<CartController>();

  final user = Rxn<UserModel>();
  final orders = <OrderModel>[].obs;
  final tabIndex = 0.obs; // 0 = Ongoing, 1 = History

  StreamSubscription? _sub;

  List<OrderModel> get ongoing => orders.where((o) => o.isOngoing).toList();
  List<OrderModel> get history => orders.where((o) => !o.isOngoing).toList();
  List<OrderModel> get visibleOrders =>
      tabIndex.value == 0 ? ongoing : history;

  String get fullAddress {
    final u = user.value;
    if (u == null) return '';
    return [u.address, u.city, u.state, u.zipCode, u.country]
        .where((e) => e.trim().isNotEmpty)
        .join(', ');
  }

  @override
  void onInit() {
    super.onInit();
    loadUser();
    _sub = _orderService.myOrders().listen(
          orders.assignAll,
          onError: (_) {},
        );
  }

  Future<void> loadUser() async {
    user.value = await _auth.getCurrentUserData();
  }

  void changeTab(int i) => tabIndex.value = i;

  void reorder(OrderModel o) {
    for (final it in o.items) {
      _cart.addItem(
        FoodItemModel(name: it.name, image: it.image, price: it.price),
        quantity: it.quantity,
      );
    }
    Get.toNamed(AppRoutes.cart);
  }

  Future<void> logout() async {
    await _auth.signOut();
    _cart.items.clear();
    Get.offAllNamed(AppRoutes.signIn);
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
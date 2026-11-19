import 'package:get/get.dart';

import '../../core/constants/app_assets.dart';
import '../../data/models/category_model.dart';
import '../../data/models/food_item_model.dart';
import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';

class HomeController extends GetxController {
  final _auth = AuthService();

  final user = Rxn<UserModel>();
  final currentTab = 0.obs;

  final categories = const <CategoryModel>[
    CategoryModel(name: 'Pizza', image: AppAssets.pizza),
    CategoryModel(name: 'Burger', image: AppAssets.burger),
    CategoryModel(name: 'Shawarma', image: AppAssets.shawarma),
    CategoryModel(name: 'Rolls', image: AppAssets.rolls),
  ];

  final popularItems = const <FoodItemModel>[
    FoodItemModel(
        name: 'Peri Peri Pizza Small', image: AppAssets.pizza, price: 500),
    FoodItemModel(
        name: 'Peri Peri Pizza Small', image: AppAssets.pizza, price: 500),
    FoodItemModel(
        name: 'Peri Peri Pizza Small', image: AppAssets.pizza, price: 500),
    FoodItemModel(
        name: 'Peri Peri Pizza Small', image: AppAssets.pizza, price: 500),
  ];

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    user.value = await _auth.getCurrentUserData();
  }

  String get greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String get firstName => (user.value?.fullName ?? 'Guest').split(' ').first;

  void changeTab(int i) => currentTab.value = i;

  void addToCart(FoodItemModel item) {
    Get.snackbar('Added', '${item.name} added to cart',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1));
  }
}

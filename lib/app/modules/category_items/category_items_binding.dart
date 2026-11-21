import 'package:get/get.dart';
import 'category_items_controller.dart';

class CategoryItemsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CategoryItemsController());
}
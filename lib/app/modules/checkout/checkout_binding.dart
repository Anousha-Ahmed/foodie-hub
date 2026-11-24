import 'package:get/get.dart';
import 'checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<CheckoutController>()) {
      Get.put(CheckoutController());
    }
  }
}
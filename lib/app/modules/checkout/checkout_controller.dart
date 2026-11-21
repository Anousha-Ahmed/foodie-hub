import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/payment_method_model.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/order_service.dart';
import '../../routes/app_routes.dart';
import '../cart/cart_controller.dart';

class CheckoutController extends GetxController {
  final cart = Get.find<CartController>();
  final _orderService = OrderService();

  // ---- Order Summary ----
  final orderId = (1000000 + Random().nextInt(9000000)).toString();
  final int deliveryCharges = 100;

  int get subtotal => cart.totalPrice;
  int get total => subtotal + deliveryCharges;

  // ---- Delivery Address ----
  final addressFormKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final instructionsController = TextEditingController();

  // ---- Payment ----
  final cardMethods = const [
    PaymentMethodModel(
        id: 'card',
        name: 'Add Card',
        asset: 'assets/icons/card.png',
        fallbackIcon: Icons.credit_card,
        fallbackColor: Color(0xFFF5A700)),
  ];

  final otherMethods = const [
    PaymentMethodModel(
        id: 'paypal',
        name: 'Paypal',
        asset: 'assets/icons/paypal.png',
        fallbackIcon: Icons.account_balance_wallet_outlined,
        fallbackColor: Color(0xFF1565C0)),
    PaymentMethodModel(
        id: 'apple_pay',
        name: 'Apple Pay',
        asset: 'assets/icons/apple_pay.png',
        fallbackIcon: Icons.apple,
        fallbackColor: Colors.black),
    PaymentMethodModel(
        id: 'google_pay',
        name: 'Google Pay',
        asset: 'assets/icons/google_pay.png',
        fallbackIcon: Icons.g_mobiledata_rounded,
        fallbackColor: Color(0xFFDB4437)),
  ];

  final selectedMethod = Rxn<PaymentMethodModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _prefillAddress();
  }

  /// Sign up me jo address diya tha wahi pehle se bhar do
  Future<void> _prefillAddress() async {
    final u = await AuthService().getCurrentUserData();
    if (u != null && addressController.text.isEmpty) {
      addressController.text =
          '${u.address}, ${u.city}, ${u.state}, ${u.zipCode}, ${u.country}';
    }
  }

  void goToAddress() => Get.toNamed(AppRoutes.deliveryAddress);

  void goToPayment() {
    if (!addressFormKey.currentState!.validate()) return;
    Get.toNamed(AppRoutes.paymentMethods);
  }

  void selectMethod(PaymentMethodModel m) => selectedMethod.value = m;

  Future<void> payAndConfirm() async {
    final method = selectedMethod.value;
    if (method == null) {
      Get.snackbar('Payment', 'Please select a payment method',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    isLoading.value = true;
    try {
      await _orderService.placeOrder(
        orderId: orderId,
        items: cart.items.toList(),
        subtotal: subtotal,
        deliveryCharges: deliveryCharges,
        total: total,
        address: addressController.text.trim(),
        instructions: instructionsController.text.trim(),
        paymentMethod: method.name,
      );
      cart.items.clear();
      Get.offAllNamed(AppRoutes.home);
      Get.snackbar('Order placed', 'Your order #$orderId has been confirmed',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Order failed', 'Something went wrong, please try again',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    instructionsController.dispose();
    super.onClose();
  }
}
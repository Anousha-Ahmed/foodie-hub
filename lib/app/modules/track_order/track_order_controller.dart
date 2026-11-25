import 'dart:async';

import 'package:get/get.dart';

import '../../data/models/order_model.dart';

class TrackOrderController extends GetxController {
  late final OrderModel order;

  static const restaurantName = 'Foodie Hub Kitchen';
  static const courierName = 'Robert F.';

  final steps = const [
    'Your order has been received',
    'The restaurant is preparing your food',
    'Your order has been picked up for delivery',
    'Order arriving soon',
  ];

  final now = DateTime.now().obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    order = Get.arguments as OrderModel;
    _timer = Timer.periodic(
        const Duration(seconds: 5), (_) => now.value = DateTime.now());
  }

  int get _totalSeconds =>
      (order.expectedMins * 60) <= 0 ? 1 : order.expectedMins * 60;

  int get _elapsedSeconds => now.value.difference(order.createdAt).inSeconds;

  double get progress => (_elapsedSeconds / _totalSeconds).clamp(0.0, 1.0);

  bool get isDelivered => progress >= 1;

  int get minutesLeft {
    final left = ((_totalSeconds - _elapsedSeconds) / 60).ceil();
    return left < 0 ? 0 : left;
  }

  int get reachedSteps {
    final p = progress;
    if (p < 0.10) return 1;
    if (p < 0.45) return 2;
    if (p < 0.85) return 3;
    return 4;
  }

  String get itemsText =>
      order.items.map((e) => '${e.quantity}x ${e.name}').join('\n');

  void callCourier() {
    Get.snackbar('Calling', 'Calling $courierName...',
        snackPosition: SnackPosition.TOP);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
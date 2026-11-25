import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/address_model.dart';
import '../../data/services/address_service.dart';
import '../../routes/app_routes.dart';

class AddressController extends GetxController {
  final _service = AddressService();

  final addresses = <AddressModel>[].obs;
  final isLoading = true.obs;
  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    _sub = _service.watch().listen(
      (list) {
        addresses.assignAll(list);
        isLoading.value = false;
      },
      onError: (_) => isLoading.value = false,
    );
  }

  void addNew() => Get.toNamed(AppRoutes.addAddress);

  void edit(AddressModel a) => Get.toNamed(AppRoutes.addAddress, arguments: a);

  void confirmDelete(AddressModel a) {
    Get.dialog(AlertDialog(
      title: const Text('Delete Address'),
      content: Text('Remove your ${a.type} address?'),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            Get.back();
            try {
              await _service.delete(a.id);
            } catch (_) {
              Get.snackbar('Delete failed', 'Please try again',
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ));
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
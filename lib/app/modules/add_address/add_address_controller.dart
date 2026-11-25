import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/address_model.dart';
import '../../data/services/address_service.dart';

class AddAddressController extends GetxController {
  final _service = AddressService();

  final formKey = GlobalKey<FormState>();
  final typeController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final countryController = TextEditingController();

  AddressModel? editing;
  final isLoading = false.obs;

  bool get isEdit => editing != null;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is AddressModel) {
      editing = arg;
      typeController.text = arg.type;
      addressController.text = arg.address;
      cityController.text = arg.city;
      stateController.text = arg.state;
      zipController.text = arg.zipCode;
      countryController.text = arg.country;
    }
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      final a = AddressModel(
        id: editing?.id ?? '',
        type: typeController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        zipCode: zipController.text.trim(),
        country: countryController.text.trim(),
        createdAt: editing?.createdAt ?? DateTime.now().millisecondsSinceEpoch,
      );
      if (isEdit) {
        await _service.update(a);
      } else {
        await _service.add(a);
      }
      Get.back();
      Get.snackbar(isEdit ? 'Address updated' : 'Address added',
          'Your address has been saved',
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      Get.snackbar('Save failed', 'Something went wrong, please try again',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
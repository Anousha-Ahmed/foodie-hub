import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../../routes/app_routes.dart';

class SignUpController extends GetxController {
  final _auth = AuthService();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final countryController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await _auth.signUp(
        fullName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        zipCode: zipController.text.trim(),
        country: countryController.text.trim(),
        password: passwordController.text,
      );
      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      String msg = e.message ?? 'Something went wrong';
      if (e.code == 'email-already-in-use') {
        msg = 'This phone number is already registered';
      } else if (e.code == 'weak-password') {
        msg = 'Password is too weak';
      }
      Get.snackbar('Sign Up Failed', msg, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignIn() => Get.back();

  @override
  void onClose() {
    for (final c in [
      nameController,
      phoneController,
      addressController,
      cityController,
      stateController,
      zipController,
      countryController,
      passwordController
    ]) {
      c.dispose();
    }
    super.onClose();
  }
}

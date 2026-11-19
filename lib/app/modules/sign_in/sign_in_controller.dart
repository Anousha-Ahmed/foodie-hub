import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../../routes/app_routes.dart';

class SignInController extends GetxController {
  final _auth = AuthService();

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await _auth.signIn(
        phone: phoneController.text.trim(),
        password: passwordController.text,
      );
      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      String msg = 'Something went wrong';
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        msg = 'Phone number or password is incorrect';
      } else if (e.code == 'network-request-failed') {
        msg = 'Check your internet connection';
      }
      Get.snackbar('Sign In Failed', msg,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void onForgotPassword() {
    Get.snackbar('Forgot Password', 'Coming soon',
        snackPosition: SnackPosition.BOTTOM);
  }

  void goToSignUp() => Get.toNamed(AppRoutes.signUp);

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

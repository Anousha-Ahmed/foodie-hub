import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';

class ChangePasswordController extends GetxController {
  final _auth = AuthService();

  final formKey = GlobalKey<FormState>();
  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();
  final isLoading = false.obs;

  String? validateNew(String? v) {
    if (v == null || v.isEmpty) return 'New password is required';
    if (v.length < 6) return 'Minimum 6 characters';
    if (v == currentController.text) {
      return 'New password must be different';
    }
    return null;
  }

  String? validateConfirm(String? v) {
    if (v == null || v.isEmpty) return 'Please confirm your password';
    if (v != newController.text) return 'Passwords do not match';
    return null;
  }

  void onForgotPassword() {
    Get.snackbar('Forgot Password',
        'Reset is not available for phone-number accounts yet',
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> updatePassword() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      await _auth.changePassword(
        current: currentController.text,
        newPassword: newController.text,
      );
      Get.back();
      Get.snackbar('Password updated', 'Your password has been changed',
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      String msg = 'Something went wrong';
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        msg = 'Current password is incorrect';
      } else if (e.code == 'weak-password') {
        msg = 'New password is too weak';
      } else if (e.code == 'requires-recent-login') {
        msg = 'Please log in again and retry';
      }
      Get.snackbar('Update failed', msg, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
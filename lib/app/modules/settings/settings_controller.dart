import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../../routes/app_routes.dart';
import '../cart/cart_controller.dart';

class SettingsController extends GetxController {
  final _auth = AuthService();
  final _cart = Get.find<CartController>();

  final passwordController = TextEditingController();
  final isDeleting = false.obs;

  void openPayment() => Get.toNamed(AppRoutes.settingsPayment);
  void openChangePassword() => Get.toNamed(AppRoutes.changePassword);
  void openAddress() => Get.toNamed(AppRoutes.addresses);

  // ---------- Log out ----------
  void confirmLogout() {
    Get.dialog(AlertDialog(
      title: const Text('Log Out'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            Get.back();
            await _auth.signOut();
            _cart.items.clear();
            Get.offAllNamed(AppRoutes.signIn);
          },
          child: const Text('Log Out', style: TextStyle(color: Colors.red)),
        ),
      ],
    ));
  }

  // ---------- Delete account ----------
  void confirmDelete() {
    passwordController.clear();
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'This will permanently delete your account and all your orders. '
                'Enter your password to confirm.'),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'Password', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          Obx(() => TextButton(
                onPressed: isDeleting.value ? null : _deleteAccount,
                child: isDeleting.value
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Delete',
                        style: TextStyle(color: Colors.red)),
              )),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _deleteAccount() async {
    if (passwordController.text.isEmpty) {
      Get.snackbar('Password required', 'Please enter your password',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    isDeleting.value = true;
    try {
      await _auth.deleteAccount(passwordController.text);
      _cart.items.clear();
      Get.offAllNamed(AppRoutes.signIn);
      Get.snackbar('Account deleted', 'Your account has been removed',
          snackPosition: SnackPosition.BOTTOM);
    } on FirebaseAuthException catch (e) {
      final wrong = e.code == 'wrong-password' || e.code == 'invalid-credential';
      Get.snackbar('Delete failed',
          wrong ? 'Incorrect password' : 'Could not delete account',
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {
      Get.snackbar('Delete failed', 'Something went wrong, try again',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isDeleting.value = false;
    }
  }
}
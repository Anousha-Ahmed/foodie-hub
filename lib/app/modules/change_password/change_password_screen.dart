import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_header.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: ScreenHeader(title: 'New Password'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Current Password',
                        hint: '****************',
                        controller: controller.currentController,
                        isPassword: true,
                        validator: (v) =>
                            Validators.required(v, 'Current password'),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: controller.onForgotPassword,
                          child: Text('Forgot Password?',
                              style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: AppColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary)),
                        ),
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'New Password',
                        hint: '****************',
                        controller: controller.newController,
                        isPassword: true,
                        validator: controller.validateNew,
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'Confirm New Password',
                        hint: '****************',
                        controller: controller.confirmController,
                        isPassword: true,
                        validator: controller.validateConfirm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 20),
              child: Obx(() => CustomButton(
                    text: 'Update Password',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.updatePassword,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
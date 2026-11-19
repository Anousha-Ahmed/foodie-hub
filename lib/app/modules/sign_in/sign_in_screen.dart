import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../widgets/auth_footer_link.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'sign_in_controller.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text('Sign In',
                          style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark)),
                      const SizedBox(height: 24),
                      Image.asset(AppAssets.shopLogo,
                          height: 110,
                          errorBuilder: (_, __, ___) => const Icon(
                              Icons.storefront,
                              size: 90,
                              color: AppColors.primary)),
                      const SizedBox(height: 40),
                      CustomTextField(
                        label: 'Phone Number',
                        hint: '+923000 0000000',
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        validator: Validators.phone,
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'Password',
                        hint: '****************',
                        controller: controller.passwordController,
                        isPassword: true,
                        validator: Validators.password,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: controller.onForgotPassword,
                          child: Text('Forgot Password?',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary)),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Obx(() => CustomButton(
                            text: 'Sign In',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.signIn,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: AuthFooterLink(
                text: "Don't have an account?",
                linkText: 'Sign up',
                onTap: controller.goToSignUp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../widgets/auth_footer_link.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'sign_up_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

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
                      Text('Sign Up',
                          style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark)),
                      const SizedBox(height: 24),
                      CustomTextField(
                        label: 'Full Name',
                        hint: 'Steve Harvey',
                        controller: controller.nameController,
                        validator: (v) => Validators.required(v, 'Full name'),
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'Phone Number',
                        hint: '+923000 0000000',
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        validator: Validators.phone,
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'Address',
                        hint: 'Address Line 1',
                        controller: controller.addressController,
                        validator: (v) => Validators.required(v, 'Address'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hint: 'City',
                              controller: controller.cityController,
                              validator: (v) => Validators.required(v, 'City'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              hint: 'State',
                              controller: controller.stateController,
                              validator: (v) => Validators.required(v, 'State'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              hint: 'Zip Code',
                              controller: controller.zipController,
                              keyboardType: TextInputType.number,
                              validator: (v) =>
                                  Validators.required(v, 'Zip code'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              hint: 'Country',
                              controller: controller.countryController,
                              validator: (v) =>
                                  Validators.required(v, 'Country'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'Password',
                        hint: '****************',
                        controller: controller.passwordController,
                        isPassword: true,
                        validator: Validators.password,
                      ),
                      const SizedBox(height: 32),
                      Obx(() => CustomButton(
                            text: 'Sign Up',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.signUp,
                          )),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: AuthFooterLink(
                text: 'Already have an account?',
                linkText: 'Sign In',
                onTap: controller.goToSignIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

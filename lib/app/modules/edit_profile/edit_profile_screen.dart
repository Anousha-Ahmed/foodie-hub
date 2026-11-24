import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/validators.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_avatar.dart';
import '../../widgets/screen_header.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  String? _email(String? v) {
    if (v == null || v.trim().isEmpty) return null; // optional
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: ScreenHeader(title: 'Edit Profile'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Obx(() => ProfileAvatar(
                            size: 84,
                            showCamera: true,
                            bytes: controller.pickedBytes.value,
                            photoBase64: controller.currentPhoto,
                            onTap: controller.pickImage,
                          )),
                      const SizedBox(height: 22),
                      CustomTextField(
                        label: 'Full Name',
                        hint: 'Steve Harvey',
                        controller: controller.nameController,
                        validator: (v) => Validators.required(v, 'Full name'),
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'Email',
                        hint: 'example@gmail.com',
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _email,
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        label: 'Phone Number',
                        hint: '+000 000 0000',
                        controller: controller.phoneController,
                        readOnly: true, // login isi number se hota hai
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
                      const SizedBox(height: 28),
                      Obx(() => CustomButton(
                            text: 'Update',
                            isLoading: controller.isLoading.value,
                            onPressed: controller.updateProfile,
                          )),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
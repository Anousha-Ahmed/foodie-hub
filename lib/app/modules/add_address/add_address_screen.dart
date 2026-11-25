import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/validators.dart';
import '../../widgets/bottom_action_bar.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_header.dart';
import 'add_address_controller.dart';

class AddAddressScreen extends GetView<AddAddressController> {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ScreenHeader(
                  title: controller.isEdit ? 'Edit Address' : 'Add New Address'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Type',
                        hint: 'eg. Work',
                        controller: controller.typeController,
                        validator: (v) => Validators.required(v, 'Type'),
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
                              validator: (v) =>
                                  Validators.required(v, 'State'),
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
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => BottomActionBar(
                  buttonText: 'Save',
                  isLoading: controller.isLoading.value,
                  onPressed: controller.save,
                )),
          ],
        ),
      ),
    );
  }
}
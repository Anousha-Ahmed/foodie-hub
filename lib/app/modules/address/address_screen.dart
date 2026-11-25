import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/screen_header.dart';
import 'address_controller.dart';
import 'widgets/address_card.dart';

class AddressScreen extends GetView<AddressController> {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ScreenHeader(title: 'Address'),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.addresses.isEmpty) {
                  return Center(
                    child: Text('No saved addresses yet',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textGrey)),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.addresses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) {
                    final a = controller.addresses[i];
                    return AddressCard(
                      address: a,
                      onEdit: () => controller.edit(a),
                      onDelete: () => controller.confirmDelete(a),
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: CustomButton(
                text: 'Add New Address',
                onPressed: controller.addNew,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
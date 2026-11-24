import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../widgets/screen_header.dart';
import 'profile_controller.dart';
import 'widgets/order_card.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_tabs.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  void _openSettings() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text('Sign Out',
                    style: GoogleFonts.poppins(fontSize: 14)),
                onTap: () {
                  Get.back();
                  controller.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ScreenHeader(
                title: 'Profile',
                onBack: () => Get.offAllNamed(AppRoutes.home),
                trailing: GestureDetector(
                  onTap: _openSettings,
                  child: const Icon(Icons.settings,
                      size: 22, color: AppColors.textDark),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => ProfileHeader(
                    user: controller.user.value,
                    address: controller.fullAddress,
                    onEdit: () => Get.toNamed(AppRoutes.editProfile),
                  )),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => ProfileTabs(
                    selectedIndex: controller.tabIndex.value,
                    onChanged: controller.changeTab,
                  )),
            ),
            Expanded(
              child: Obx(() {
                final list = controller.visibleOrders;
                final isHistory = controller.tabIndex.value == 1;
                if (list.isEmpty) {
                  return Center(
                    child: Text(
                        isHistory ? 'No past orders yet' : 'No ongoing orders',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textGrey)),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (_, i) => OrderCard(
                    order: list[i],
                    showReorder: isHistory,
                    onReorder: () => controller.reorder(list[i]),
                  ),
                );
              }),
            ),
            CustomBottomNav(
              currentIndex: 2,
              onTap: (i) {
                if (i == 0) Get.offAllNamed(AppRoutes.home);
                if (i == 1) Get.offNamed(AppRoutes.cart);
              },
            ),
          ],
        ),
      ),
    );
  }
}
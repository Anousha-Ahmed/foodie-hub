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
                  onTap: () => Get.toNamed(AppRoutes.settings),
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
                  itemBuilder: (_, i) => GestureDetector(
                  onTap: isHistory
                      ? null
                      : () => Get.toNamed(AppRoutes.trackOrder, arguments: list[i]),
                  child: OrderCard(
                    order: list[i],
                    showReorder: isHistory,
                    onReorder: () => controller.reorder(list[i]),
                  ),
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
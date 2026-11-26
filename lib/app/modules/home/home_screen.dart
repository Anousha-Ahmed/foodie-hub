import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'home_controller.dart';
import 'widgets/category_item.dart';
import 'widgets/food_card.dart';
import 'widgets/home_header.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.currentTab.value != 0) {
            return Center(
              child: Text('Profile',
                  style: GoogleFonts.poppins(fontSize: 18)),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    HomeHeader(
                      name: controller.user.value?.fullName ?? 'Guest',
                      country: controller.user.value?.country ?? '',
                      photoBase64: controller.user.value?.photoBase64 ?? '',
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: AppColors.textDark),
                        children: [
                          TextSpan(text: 'Hey ${controller.firstName}, '),
                          TextSpan(
                              text: controller.greeting,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Categories',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                        GestureDetector(
                          onTap: controller.openAllCategories,
                          child: Row(children: [
                            Text('See All',
                                style: GoogleFonts.poppins(fontSize: 12)),
                            const Icon(Icons.chevron_right, size: 18),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: controller.categories
                          .map((c) => CategoryItem(
                                category: c,
                                onTap: () => controller.openCategory(c),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 26),
                    Text('Most Popular',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                  ]),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.82,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => FoodCard(
                      item: controller.popularItems[i],
                      onAdd: () =>
                          controller.addToCart(controller.popularItems[i]),
                    ),
                    childCount: controller.popularItems.length,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(() => CustomBottomNav(
            currentIndex: controller.currentTab.value,
            onTap: controller.onNavTap,
          )),
    );
  }
}

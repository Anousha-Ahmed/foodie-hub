import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/screen_header.dart';
import 'settings_controller.dart';
import 'widgets/settings_tile.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final divider = Divider(height: 1, color: Colors.grey.shade300);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: ScreenHeader(title: 'Settings'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  SettingsTile(
                    icon: Icons.credit_card,
                    title: 'Payment Method',
                    showArrow: true,
                    onTap: controller.openPayment,
                  ),
                  divider,
                  SettingsTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    showArrow: true,
                    onTap: controller.openChangePassword,
                  ),
                  divider,
                  SettingsTile(
                    icon: Icons.location_on,
                    title: 'Address',
                    onTap: controller.openAddress,
                  ),
                  divider,
                  SettingsTile(
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    onTap: controller.confirmDelete,
                  ),
                  divider,
                  SettingsTile(
                    icon: Icons.logout,
                    title: 'Log Out',
                    onTap: controller.confirmLogout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
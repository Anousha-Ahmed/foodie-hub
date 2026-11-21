import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CustomBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  static const _items = [
    (Icons.home_rounded, 'Home'),
    (Icons.shopping_cart_rounded, 'Cart'),
    (Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final selected = i == currentIndex;
          final color = selected ? AppColors.accent : AppColors.textGrey;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(i),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_items[i].$1, color: color, size: 26),
                const SizedBox(height: 2),
                Text(_items[i].$2,
                    style: GoogleFonts.poppins(fontSize: 11, color: color)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
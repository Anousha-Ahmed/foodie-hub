import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';

class ProfileTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  const ProfileTabs(
      {super.key, required this.selectedIndex, required this.onChanged});

  static const _labels = ['Ongoing', 'History'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_labels.length, (i) {
        final selected = i == selectedIndex;
        return Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(i),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(_labels[i],
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.w400,
                          color: selected
                              ? AppColors.textDark
                              : AppColors.textGrey)),
                ),
                Container(
                  height: 1.5,
                  color: selected ? AppColors.primary : Colors.grey.shade300,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
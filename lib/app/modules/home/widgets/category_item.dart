import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;
  const CategoryItem({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(category.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    width: 50,
                    height: 50,
                    color: Colors.orange.shade100,
                    child: const Icon(Icons.fastfood, color: Colors.orange))),
          ),
          const SizedBox(height: 6),
          Text(category.name,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: AppColors.textDark)),
        ],
      ),
    );
  }
}

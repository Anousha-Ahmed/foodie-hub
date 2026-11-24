import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../data/models/user_model.dart';
import '../../../widgets/profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel? user;
  final String address;
  final VoidCallback onEdit;
  const ProfileHeader(
      {super.key,
      required this.user,
      required this.address,
      required this.onEdit});

  Widget _line(String text, {double size = 9, Color? color}) => Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(text,
            style: GoogleFonts.poppins(
                fontSize: size, color: color ?? AppColors.textDark)),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAvatar(photoBase64: user?.photoBase64 ?? '', size: 66),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user?.fullName ?? '',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary)),
              if ((user?.email ?? '').isNotEmpty) _line(user!.email),
              _line(user?.phone ?? ''),
              if (address.isNotEmpty)
                _line(address, size: 8, color: AppColors.textGrey),
            ],
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.edit_outlined,
                size: 20, color: AppColors.textDark),
          ),
        ),
      ],
    );
  }
}
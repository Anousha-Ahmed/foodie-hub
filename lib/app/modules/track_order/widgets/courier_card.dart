import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourierCard extends StatelessWidget {
  final String name;
  final VoidCallback onCall;
  const CourierCard({super.key, required this.name, required this.onCall});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipOval(
            // Figma se courier ki photo export karke is naam se rakh sakti hain
            child: Image.asset('assets/images/courier.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.person, color: Colors.grey))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1B1B3A))),
                Text('Courier',
                    style: GoogleFonts.poppins(
                        fontSize: 10, color: const Color(0xFF9A9CAA))),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCall,
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                  color: Color(0xFFFF8A00), shape: BoxShape.circle),
              child: const Icon(Icons.phone, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
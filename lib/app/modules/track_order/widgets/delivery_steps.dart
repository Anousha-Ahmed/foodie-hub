import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliverySteps extends StatelessWidget {
  final List<String> steps;
  final int reached; 

  const DeliverySteps({super.key, required this.steps, required this.reached});

  static const _orange = Color(0xFFFF8A00);
  static const _grey = Color(0xFFB8BBC6);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (i) {
        final done = i < reached;
        final last = i == steps.length - 1;
        final nextDone = i + 1 < reached;
        return SizedBox(
          height: last ? 18 : 38,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 16,
                child: Column(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                          color: done ? _orange : _grey,
                          shape: BoxShape.circle),
                      child: const Icon(Icons.check,
                          size: 9, color: Colors.white),
                    ),
                    if (!last)
                      Expanded(
                        child: Container(
                            width: 1.5, color: nextDone ? _orange : _grey),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(steps[i],
                    style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: done ? _orange : const Color(0xFF9A9CAA))),
              ),
            ],
          ),
        );
      }),
    );
  }
}
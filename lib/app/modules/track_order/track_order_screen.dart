import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/formatters.dart';
import 'track_order_controller.dart';
import 'widgets/courier_card.dart';
import 'widgets/delivery_steps.dart';
import 'widgets/route_map.dart';

class TrackOrderScreen extends GetView<TrackOrderController> {
  const TrackOrderScreen({super.key});

  static const _navy = Color(0xFF1B1B3A);
  static const _greyText = Color(0xFF9A9CAA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map (background)
          Positioned.fill(
            child: Obx(() => RouteMap(progress: controller.progress)),
          ),

          // Back + title
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                          color: _navy, shape: BoxShape.circle),
                      child: const Icon(Icons.chevron_left,
                          color: Colors.white, size: 22),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Track Order',
                      style: GoogleFonts.poppins(
                          fontSize: 12, color: _navy)),
                ],
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.24,
            minChildSize: 0.24,
            maxChildSize: 0.72,
            snap: true,
            snapSizes: const [0.24, 0.72],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 14),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                  children: [
                    // handle
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Restaurant + order info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: controller.order.items.isEmpty
                              ? _thumbPlaceholder()
                              : Image.asset(
                                  controller.order.items.first.image,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      _thumbPlaceholder(),
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(TrackOrderController.restaurantName,
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _navy)),
                              const SizedBox(height: 2),
                              Text(
                                  'Ordered At ${Formatters.orderedAt(controller.order.createdAt)}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 10, color: _greyText)),
                              const SizedBox(height: 6),
                              Text(controller.itemsText,
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      height: 1.5,
                                      color: _navy)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Estimated time
                    Obx(() => Column(
                          children: [
                            Text(
                                controller.isDelivered
                                    ? 'Delivered'
                                    : '${controller.minutesLeft} min',
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: _navy)),
                            Text(
                                controller.isDelivered
                                    ? 'ENJOY YOUR MEAL'
                                    : 'ESTIMATED DELIVERY TIME',
                                style: GoogleFonts.poppins(
                                    fontSize: 9,
                                    letterSpacing: 0.8,
                                    color: _greyText)),
                          ],
                        )),

                    const SizedBox(height: 22),

                    // Steps
                    Obx(() => DeliverySteps(
                          steps: controller.steps,
                          reached: controller.reachedSteps,
                        )),

                    const SizedBox(height: 22),

                    CourierCard(
                      name: TrackOrderController.courierName,
                      onCall: controller.callCourier,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _thumbPlaceholder() => Container(
        width: 56,
        height: 56,
        color: const Color(0xFF9AA5B4),
        child: const Icon(Icons.fastfood, color: Colors.white),
      );
}
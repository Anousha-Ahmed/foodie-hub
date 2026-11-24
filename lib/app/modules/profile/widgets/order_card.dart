import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final bool showReorder;
  final VoidCallback? onReorder;

  const OrderCard({
    super.key,
    required this.order,
    this.showReorder = false,
    this.onReorder,
  });

  TextStyle get _label =>
      GoogleFonts.poppins(fontSize: 9, color: AppColors.textGrey);
  TextStyle get _value => GoogleFonts.poppins(
      fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textDark);

  Widget _pair(String label, String value) => Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: _label),
            const SizedBox(width: 12),
            Text(value, style: _value),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                  fontSize: 11, color: AppColors.textDark),
              children: [
                const TextSpan(text: 'Order ID '),
                TextSpan(
                    text: '#${order.orderId}',
                    style: const TextStyle(color: AppColors.accent)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.dateText, style: _label),
                  _pair('Items', '${order.itemCount}'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _pair('Expected Delivery', '${order.expectedMins} Mins'),
                  _pair('Total Amount', Formatters.price(order.total)),
                ],
              ),
            ],
          ),
          if (showReorder) ...[
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 110,
                height: 24,
                child: ElevatedButton(
                  onPressed: onReorder,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text('Re-Order',
                      style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
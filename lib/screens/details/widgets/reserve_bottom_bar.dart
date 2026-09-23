import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ReserveBottomBar extends StatelessWidget {
  final double price;
  final String period;
  final VoidCallback? onReserveTap;

  const ReserveBottomBar({
    super.key,
    required this.price,
    this.period = '/week',
    this.onReserveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F1F4))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Total', style: TextStyle(fontSize: 14, color: kGrey)),
                const SizedBox(height: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '\$${price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: kInk,
                        ),
                      ),
                      TextSpan(
                        text: ' $period',
                        style: const TextStyle(fontSize: 13, color: kGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onReserveTap,
            child: Container(
              height: 51,
              width: 154,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Reserve',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

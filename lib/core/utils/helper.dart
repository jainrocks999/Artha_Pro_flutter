import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final NumberFormat currencyFormat = NumberFormat.currency(
  locale: 'en_IN',
  symbol: '₹',
  decimalDigits: 0,
);

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    IconData icon = Icons.info,
    Color iconBgColor = const Color(0xffff2414),
    String? actionText,
    VoidCallback? onAction,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        content: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 400),
          tween: Tween(begin: 50, end: 0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, value),
              child: Opacity(opacity: 1 - (value / 50), child: child),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff1a0033), Color(0xff2b004d)],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.primaryLight,
                width: 2,
              )
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor.withAlpha(81),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconBgColor, size: 20),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.primaryLightText,
                          fontFamily: 'Manrope',
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      Text(
                        message,
                        style: const TextStyle(
                          color: AppColors.primaryLightText,
                          fontFamily: 'Manrope',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                if (actionText != null && onAction != null)
                  TextButton(
                    onPressed: onAction,
                    child: Text(
                      actionText,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

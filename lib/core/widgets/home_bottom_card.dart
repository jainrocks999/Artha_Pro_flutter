import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HomeBottomCard extends StatelessWidget {
  const HomeBottomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Container(
            color: AppColors.primary,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(
                  "Tip of the day".toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  "Diversification Strategy",
                  style: const TextStyle(
                    color: AppColors.primaryLightText,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Consider rebalancing your equity portfolio to maintain your desired risk profile after the recent market rally.",
                  style: TextStyle(
                    color: AppColors.secondaryLightText,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    letterSpacing: 1.2,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -35,
            top: -28,
            child: Icon(
              Icons.lightbulb_rounded,
              size: 140,
              color: AppColors.secondary.withAlpha(51),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CalculatorTopHeader extends StatelessWidget {
  final String title;
  final String description;
  const CalculatorTopHeader({super.key,required this.title,required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          title,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: AppDarkColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryLightText,
          ),
        ),
      ],
    );
  }
}

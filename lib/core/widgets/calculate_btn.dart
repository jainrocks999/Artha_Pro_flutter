import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CalculateBtn extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double height;
  final double borderRadius;

  const CalculateBtn({
    super.key,
    required this.title,
    required this.onPressed,
    this.height = 60,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          onPressed();
        },
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColors.primaryDarkText,
          ),
        ),
      ),
    );
  }
}

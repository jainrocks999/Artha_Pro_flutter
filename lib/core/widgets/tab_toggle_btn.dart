import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TabToggleBtn extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double verticalPadding;

  const TabToggleBtn({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.verticalPadding=15
  });

  @override
  Widget build(BuildContext context) {
    return  TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w900,
          fontSize: 14,
          color: isSelected ? AppColors.primaryLightText : AppColors.slateLight,
        ),
      ),
    );
  }
}

import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CircleDecoration extends StatelessWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double? size;

  const CircleDecoration({
    super.key,
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Icon(
        Icons.circle,
        size: size,
        color: AppColors.secondary.withAlpha(51),
      ),
    );
  }
}
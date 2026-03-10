import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InvestmentChart extends StatelessWidget {
  final double principalAmount;
  final Color principalColor;
  final double interestAmount;
  final Color interestColor;
  final String title;
  final dynamic totalAmount;
  final double centerSpaceRadius;

  const InvestmentChart({
    super.key,
    required this.principalAmount,
    required this.interestAmount,
    required this.title,
    required this.principalColor,
    required this.interestColor,
    this.totalAmount,
    this.centerSpaceRadius=70
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            startDegreeOffset: -90,
            sectionsSpace: 0,
            centerSpaceRadius: centerSpaceRadius,
            sections: [
              PieChartSectionData(
                value: principalAmount,
                color: principalColor,
                radius: 20,
                showTitle: false,
              ),
              PieChartSectionData(
                value: interestAmount,
                color: interestColor,
                radius: 20,
                showTitle: false,
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontFamily: "Manrope",
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: AppColors.secondaryDarkText,
              ),
            ),
            const SizedBox(height: 6),
            totalAmount != null
                ? Text(
                    totalAmount,
                    style: const TextStyle(
                      fontFamily: "Manrope",
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.secondaryDarkText,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}

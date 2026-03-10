import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTopCard extends StatelessWidget {
  const HomeTopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(width: 1, color: Color(0xff422f59)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Smart Financial\nToolkit',
                  style: TextStyle(
                    color: AppColors.primaryLightText,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                ),
                Card(
                  color: AppColors.secondary.withAlpha(51),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(
                      width: 1,
                      color: AppColors.secondary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      'assets/icons/license.svg',
                      height: 18,
                      width: 18,
                    ),
                  ),
                ),
              ],
            ),

            const Text(
              "Plan. Calculate. Grow.",
              style: TextStyle(
                color: AppColors.primaryLightText,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.normal,
                fontSize: 13,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.left,
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              height: 3.5,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            Text(
              "25+ Indian Financial Calculators".toUpperCase(),
              style: const TextStyle(
                color: AppColors.secondary,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 105,
                  height: 38,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Expore All',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontFamily: 'Manrope',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 105,
                  height: 38,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryLightText.withAlpha(40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: AppColors.primaryLightText.withAlpha(50),
                          width: 1,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'How it works',
                      style: TextStyle(
                        color: AppColors.primaryLightText,
                        fontFamily: 'Manrope',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

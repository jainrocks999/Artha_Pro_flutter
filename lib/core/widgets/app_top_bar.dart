import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const AppTopBar({super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: AppColors.primary,
      title: title != null
          ? Text(
              title.toString(),
              style: const TextStyle(
                color: AppColors.primaryLightText,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w700,
              ),
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Artha',
                  style: TextStyle(
                    color: AppColors.primaryLightText,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Pro',
                  style: TextStyle(
                    color: AppColors.secondaryLight,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
    );
  }
}

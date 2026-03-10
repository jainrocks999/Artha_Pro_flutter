import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LightAppTopbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const LightAppTopbar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppDarkColors.appBarColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppDarkColors.secondaryLightText.withAlpha(80),
        ),
      ),
      iconTheme: IconThemeData(color: AppDarkColors.primary),
      title: Text(
        title,
        style:const TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w700,
          color: AppDarkColors.primary,
          fontSize: 18,
        ),
      ),
    );
  }
}

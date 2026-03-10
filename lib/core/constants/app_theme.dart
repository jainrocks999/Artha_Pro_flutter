import 'package:artha_pro_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.primaryBg,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarColor,
      elevation: 0,
    ),

    colorScheme: const ColorScheme(
      primary: AppColors.primary,
      brightness: Brightness.light,
      onPrimary: AppColors.primaryLightText,
      secondary: AppColors.secondary,
      onSecondary: AppColors.secondaryLightText,
      surface: AppColors.textColor,
      onSurface: AppColors.primaryLight,
      error: Colors.red,
      onError: Colors.red,
    ),
    cardColor: AppColors.smCardColor,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputColor,
      border: AppInputeBorders.primary(),
      enabledBorder: AppInputeBorders.primary(),
      focusedBorder: AppInputeBorders.primary(),
      errorBorder: AppInputeBorders.error(),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppDarkColors.primaryBg,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppDarkColors.appBarColor,
      elevation: 0,
    ),

    colorScheme: const ColorScheme(
      primary: AppDarkColors.primary,
      brightness: Brightness.dark,
      onPrimary: AppDarkColors.primaryLightText,
      secondary: AppColors.secondary,
      onSecondary: AppDarkColors.secondaryLightText,
      surface: AppDarkColors.textColor,
      onSurface: AppColors.inputColor,
      error: Colors.red,
      onError: Colors.red,
    ),
    cardColor: AppDarkColors.smCardColor,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppDarkColors.inputColor,
      border: AppInputeBorders.primary(),
    ),
  );
}

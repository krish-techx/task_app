import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class AppTheme {
  static ThemeData getThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.white,
    );
  }
}

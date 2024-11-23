import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: AppColors.dashboardColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.backgroundColor,
      )
    )
  );
}
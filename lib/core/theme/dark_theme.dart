import 'package:flutter/material.dart';

import 'AppColors.dart';

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.darkBackground,

      primaryColor: AppColors.primaryGold,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGold,
        brightness: Brightness.dark,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.lightGold,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.lightGold,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardColor: AppColors.darkCard,

      dividerColor: AppColors.darkDivider,

      iconTheme: IconThemeData(
        color: AppColors.lightGold,
      ),

      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.darkText,
        ),
        bodyMedium: TextStyle(
          color: AppColors.darkSecondaryText,
        ),
        titleLarge: TextStyle(
          color: AppColors.lightGold,
          fontWeight: FontWeight.bold,
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(
          AppColors.primaryGold,
        ),
        trackColor: WidgetStateProperty.all(
          AppColors.lightGold.withOpacity(.4),
        ),
      ),
    );
  }
}
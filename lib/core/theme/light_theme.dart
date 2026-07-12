import 'package:flutter/material.dart';

import 'AppColors.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.background,

      primaryColor: AppColors.primaryGold,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGold,
        brightness: Brightness.light,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.darkGold,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.darkGold,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardColor: Colors.white,

      dividerColor: Colors.black12,

      iconTheme: IconThemeData(
        color: AppColors.darkGold,
      ),

      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.font_elfra,
        ),
        bodyMedium: TextStyle(
          color: AppColors.font_elfra,
        ),
        titleLarge: TextStyle(
          color: AppColors.darkGold,
          fontWeight: FontWeight.bold,
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(
          AppColors.primaryGold,
        ),
        trackColor: WidgetStateProperty.all(
          AppColors.primaryGold.withOpacity(.4),
        ),
      ),
    );
  }
}
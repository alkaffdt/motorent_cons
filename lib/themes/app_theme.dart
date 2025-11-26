import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffold,
      elevation: 0,
      foregroundColor: AppColors.textPrimary,
      centerTitle: true,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.background,
      error: AppColors.error,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
      bodySmall: TextStyle(fontSize: 12, color: AppColors.textLight),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.extraLightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: AppColors.textLight),
    ),
  );
}

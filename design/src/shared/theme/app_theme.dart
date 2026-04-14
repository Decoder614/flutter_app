import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Global ThemeData definitions.
class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      
      // We map our custom AppColors into the Material ColorScheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        background: AppColors.background,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      
      // We map our custom Typography into Material TextTheme
      textTheme: const TextTheme(
        displayLarge: AppTypography.heading1,
        bodyLarge: AppTypography.bodyText,
        bodySmall: AppTypography.caption,
      ),
      
      // Globally theme components so developers don't have to style them manually
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  // TODO: Add darkTheme property here when required.
}

import 'package:flutter/material.dart';

/// Single Source of Truth for all color definitions.
/// NEVER use `Colors.red` directly in UI. Use `AppColors.error`.
class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF6200EE);
  static const Color primaryDark = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryDark = Color(0xFF018786);
  
  static const Color background = Color(0xFFF6F6F6);
  static const Color surface = Colors.white;
  
  static const Color error = Color(0xFFB00020);
  
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
}

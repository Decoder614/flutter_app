import 'package:flutter/material.dart';

/// Small, **safe convenience extensions** for BuildContext.
/// NO state mutation. NO business logic. NO navigation logic here.
extension ContextExtensions on BuildContext {
  /// Safely get the current ThemeData
  ThemeData get theme => Theme.of(this);
  
  /// Safely get the TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Safely get the ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  
  /// Get screen width
  double get screenWidth => MediaQuery.sizeOf(this).width;
  
  /// Get screen height
  double get screenHeight => MediaQuery.sizeOf(this).height;
  
  /// Helper to check if keyboard is currently visible
  bool get isKeyboardVisible => MediaQuery.viewInsetsOf(this).bottom > 0;
}

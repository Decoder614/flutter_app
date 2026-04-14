import 'package:flutter/material.dart';

/// Generates consistent vertical and horizontal spacing.
/// Eliminates raw `SizedBox(height: 15)` widgets across the app.
class AppSpacer extends StatelessWidget {
  final double width;
  final double height;

  const AppSpacer.v8({super.key}) : height = 8, width = 0;
  const AppSpacer.v16({super.key}) : height = 16, width = 0;
  const AppSpacer.v24({super.key}) : height = 24, width = 0;
  
  const AppSpacer.h8({super.key}) : height = 0, width = 8;
  const AppSpacer.h16({super.key}) : height = 0, width = 16;
  const AppSpacer.h24({super.key}) : height = 0, width = 24;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}

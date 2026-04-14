import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Generic centered loading indicator.
class InitialLoader extends StatelessWidget {
  const InitialLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }
}

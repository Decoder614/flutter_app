import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../buttons/primary_button.dart';
import '../widgets/app_spacer.dart';

/// Generic Error Screen.
/// Has zero business logic. Does NOT know what feature failed.
class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorScreen({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppColors.error),
              const AppSpacer.v24(),
              const Text(
                'Oops!',
                style: AppTypography.heading1,
              ),
              const AppSpacer.v8(),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTypography.bodyText,
              ),
              const AppSpacer.v24(),
              PrimaryButton(
                text: 'Try Again',
                onPressed: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

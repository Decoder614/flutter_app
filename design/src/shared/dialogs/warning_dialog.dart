import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../buttons/primary_button.dart';

/// Standalone Warning Dialog widget. Needs zero context of what feature invoked it.
class WarningDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const WarningDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  /// Factory method to easily show the dialog from anywhere.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    return showDialog(
      context: context,
      builder: (context) => WarningDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.error),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          // Navigating away from a dialog is the absolute ONLY time 
          // Navigator.pop() is permitted inside presentation.
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Cancel'),
        ),
        PrimaryButton(
          width: 100,
          text: 'Confirm',
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
        ),
      ],
    );
  }
}

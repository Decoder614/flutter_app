import 'package:flutter/material.dart';

/// Reusable Primary Button.
/// Strictly a "Dumb Component": No Bloc, No API calls, No Domain logic.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double width;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48,
      child: ElevatedButton(
        // NEVER pass null to onPressed if you want a custom disabled style,
        // handle it through the theme or specific states.
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}

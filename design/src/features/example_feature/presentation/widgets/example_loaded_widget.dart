import 'package:flutter/material.dart';
import 'package:location_app/shared/theme/app_typography.dart';
import '../../domain/entities/example_entity.dart';

/// Reusable UI component specific to this feature.
/// STRICT RULES: Stateless whenever possible. No logic beyond UI.
class ExampleLoadedWidget extends StatelessWidget {
  final ExampleEntity entity;

  const ExampleLoadedWidget({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          entity.message,
          style: AppTypography.heading1,
          textAlign: TextAlign.center,
        ),
        Text(
          'Created: ${entity.createdAt.toLocal()}',
          style: AppTypography.caption,
        ),
      ],
    );
  }
}

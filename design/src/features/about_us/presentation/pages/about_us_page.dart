import 'package:flutter/material.dart';
import 'package:location_app/shared/theme/app_typography.dart';
import 'package:location_app/shared/widgets/app_spacer.dart';

import '../widgets/team_member_card.dart';

/// The top-level screen for the About Us feature.
/// 
/// Because this feature is "Pure GUI" (static content, no API calls, no DB),
/// it STRICTLY adheres to the "Boilerplate Fatigue" rule. There is NO `data/` 
/// or `domain/` layer, and NO Bloc is required. Just a clean Presentation layer.
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Mission',
              style: AppTypography.heading1,
            ),
            const AppSpacer.v16(),
            const Text(
              'We are on a mission to build the most scalable, stable, '
              'and beautiful Flutter application in existence.',
              style: AppTypography.bodyText,
            ),
            const AppSpacer.v24(),
            const Text(
              'The Team',
              style: AppTypography.heading1,
            ),
            const AppSpacer.v16(),
            
            // Example of a feature-specific widget.
            // Notice it is imported locally from `../widgets/`
            const TeamMemberCard(
              name: 'Jaydip',
              role: 'Lead Architect',
            ),
          ],
        ),
      ),
    );
  }
}

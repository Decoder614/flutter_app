import 'package:flutter/material.dart';
import 'package:location_app/shared/theme/app_colors.dart';
import 'package:location_app/shared/theme/app_typography.dart';
import 'package:location_app/shared/widgets/app_spacer.dart';

/// A widget specific to the About Us feature.
/// It is NOT placed in `shared/widgets/` because no other feature in the app
/// will ever need a "Team Member Card". It belongs locally here in the feature.
class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;

  const TeamMemberCard({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
            const AppSpacer.h16(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.bodyText.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const AppSpacer.v8(),
                Text(
                  role,
                  style: AppTypography.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// A reusable avatar widget used for user profiles and chat.
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final Color? backgroundColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.radius = 24.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? AppColors.surface,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Icon(Icons.person, size: radius, color: AppColors.textSecondary)
          : null,
    );
  }
}

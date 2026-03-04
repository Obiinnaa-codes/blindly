import 'package:flutter/material.dart';
import '../theme/colors.dart';

/// A reusable branded loading indicator for the Blindly app.
class AppLoader extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const AppLoader({
    super.key,
    this.size = 24.0,
    this.strokeWidth = 3.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primaryRed,
          ),
        ),
      ),
    );
  }
}

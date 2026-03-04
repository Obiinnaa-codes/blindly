import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

/// The standard branded logo text for the Blindly app.
class LogoText extends StatelessWidget {
  final double fontSize;

  const LogoText({super.key, this.fontSize = 48});

  @override
  Widget build(BuildContext context) {
    return Text(
      'blindly',
      style: GoogleFonts.poppins(
        color: AppColors.primaryRed,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.5,
      ),
    );
  }
}

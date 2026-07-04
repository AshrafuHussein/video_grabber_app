import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextTheme get textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.robotoFlex(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 64 / 57,
        letterSpacing: -0.25,
      ),
      headlineLarge: GoogleFonts.robotoFlex(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 40 / 32,
      ),
      headlineMedium: GoogleFonts.robotoFlex( // Used for headline-lg-mobile
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 36 / 28,
      ),
      titleLarge: GoogleFonts.robotoFlex(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 28 / 22,
      ),
      bodyLarge: GoogleFonts.robotoFlex(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.robotoFlex(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        letterSpacing: 0.25,
      ),
      labelLarge: GoogleFonts.robotoFlex(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.robotoFlex(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        letterSpacing: 0.5,
      ),
    );
  }
}

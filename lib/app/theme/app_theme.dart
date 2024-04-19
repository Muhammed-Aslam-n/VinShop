import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vinnovatelabz_app/app/theme/app_colors.dart';

/// App's theme config file

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData.light().copyWith(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: const Color(0xFFf5f9fa),
    appBarTheme: const AppBarTheme(color: Color(0xFFf5f9fa)),
    textTheme: GoogleFonts.urbanistTextTheme(
      ThemeData.light().textTheme,
    ),
    primaryTextTheme: GoogleFonts.urbanistTextTheme(
      ThemeData.light().primaryTextTheme,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        fixedSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}

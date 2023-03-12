import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultPadding = 16;
const double defaultRadius = 16;

class Palette {
  static const neutral300 = Color(0xFFFFFFFF);
  static const neutral500 = Color(0xFFEBEBEB);
  static const neutral900 = Color(0xFF000000);
  static const secondary500 = Color(0xFF0A113C);
  static const blue = Color(0xFFD6F2FF);
  static const orange = Color(0xFFFFE4C7);
  static const green = Color(0xFFDFFFD8);
  static const red = Color(0xFFFFD1D1);
}

final themeConfig = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Palette.secondary500,
    onPrimary: Palette.neutral300,
    secondary: Palette.secondary500,
    onSecondary: Palette.neutral300,
    error: Colors.red,
    onError: Colors.black,
    background: Palette.neutral300,
    onBackground: Palette.neutral900,
    surface: Palette.neutral300,
    onSurface: Palette.neutral900,
  ),
  brightness: Brightness.light,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: const TextTheme().copyWith(
    headlineLarge: GoogleFonts.poppins().copyWith(
      fontSize: 24,
      color: Palette.secondary500,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.poppins().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.poppins().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  ),
);

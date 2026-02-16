import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF0063BF);
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue700 = Color(0xFF1D4ED8);
  static const Color blue800 = Color(0xFF1E40AF);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue200 = Color(0xFFBFDBFE);

  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);
  static const Color green50 = Color(0xFFF0FDF4);

  static const Color orange500 = Color(0xFFF97316);
  static const Color orange600 = Color(0xFFEA580C);
  static const Color orange50 = Color(0xFFFFF7ED);

  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red50 = Color(0xFFFEF2F2);

  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Gradient
  static const LinearGradient blueGradient = LinearGradient(
    colors: [blue600, blue800],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient blueGradientBR = LinearGradient(
    colors: [blue600, blue800],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles
  static TextStyle get headingXL => GoogleFonts.inter(
        fontSize: 40,
        fontWeight: FontWeight.w900,
        color: gray900,
        letterSpacing: -1.0,
      );

  static TextStyle get headingLG => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: gray900,
        letterSpacing: -0.5,
      );

  static TextStyle get headingMD => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: gray900,
        letterSpacing: -0.3,
      );

  static TextStyle get headingSM => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: gray900,
      );

  static TextStyle get bodyLG => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: gray600,
      );

  static TextStyle get bodyMD => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: gray600,
      );

  static TextStyle get bodySM => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: gray500,
      );

  static TextStyle get bodyXS => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: gray400,
      );

  static TextStyle get labelXS => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: gray400,
        letterSpacing: 2.0,
      );

  static TextStyle get buttonLG => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: white,
      );

  static TextStyle get buttonMD => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: white,
      );

  // Border Radius
  static const double radiusXS = 8;
  static const double radiusSM = 12;
  static const double radiusMD = 16;
  static const double radiusLG = 24;
  static const double radiusXL = 32;
  static const double radius2XL = 40;
  static const double radius3XL = 48;

  // Shadows
  static List<BoxShadow> get shadowSM => [
        BoxShadow(
          color: gray900.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMD => [
        BoxShadow(
          color: gray900.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLG => [
        BoxShadow(
          color: gray900.withValues(alpha: 0.12),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get shadowBlue => [
        BoxShadow(
          color: blue600.withValues(alpha: 0.25),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  // ThemeData
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryBlue,
        scaffoldBackgroundColor: white,
        colorScheme: const ColorScheme.light(
          primary: primaryBlue,
          secondary: blue600,
          surface: white,
          error: red500,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: white,
          elevation: 0,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: gray900,
          ),
          iconTheme: const IconThemeData(color: gray900),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusLG),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: gray50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLG),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLG),
            borderSide: const BorderSide(color: blue100, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          hintStyle: GoogleFonts.inter(
            color: gray300,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}

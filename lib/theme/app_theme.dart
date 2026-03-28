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

  // Bybit-inspired Dark Theme Colors
  static const Color darkBg = Color(0xFF0B0E11);
  static const Color darkSurface = Color(0xFF181A20);
  static const Color darkCard = Color(0xFF1E2329);
  static const Color darkHighlight = Color(0xFF2B3139);
  static const Color accentGold = Color(0xFFFFB11A);
  static const Color darkText = Color(0xFFEAECEF);
  static const Color darkTextSecondary = Color(0xFF848E9C);

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

  static const LinearGradient goldGradient = LinearGradient(
    colors: [accentGold, Color(0xFFFFD166)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles
  static TextStyle get headingXL => GoogleFonts.outfit(
        fontSize: 40,
        fontWeight: FontWeight.w900,
        color: gray900,
        letterSpacing: -1.0,
      );

  static TextStyle get headingLG => GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: gray900,
        letterSpacing: -0.5,
      );

  static TextStyle get headingMD => GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: gray900,
        letterSpacing: -0.3,
      );

  static TextStyle get headingSM => GoogleFonts.outfit(
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
  static const double radiusLG = 20;
  static const double radiusXL = 24;
  static const double radius2XL = 32;

  // Shadows
  static List<BoxShadow> get shadowSM => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMD => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLG => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];

  // ThemeData
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: accentGold,
        scaffoldBackgroundColor: white,
        colorScheme: const ColorScheme.light(
          primary: accentGold,
          onPrimary: darkBg,
          secondary: accentGold,
          surface: white,
          error: red500,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: white,
          elevation: 0,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: gray900,
          ),
          iconTheme: const IconThemeData(color: gray900),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentGold,
            foregroundColor: darkBg,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusSM),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: accentGold,
        scaffoldBackgroundColor: darkBg,
        cardColor: darkCard,
        colorScheme: const ColorScheme.dark(
          primary: accentGold,
          onPrimary: darkBg,
          secondary: accentGold,
          surface: darkSurface,
          error: red500,
          onSurface: darkText,
        ),
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: darkText,
          displayColor: darkText,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkBg,
          elevation: 0,
          titleTextStyle: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
          iconTheme: const IconThemeData(color: darkText),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentGold,
            foregroundColor: darkBg,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusSM),
            ),
            textStyle: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSM),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSM),
            borderSide: const BorderSide(color: accentGold, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintStyle: GoogleFonts.inter(
            color: darkTextSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

}

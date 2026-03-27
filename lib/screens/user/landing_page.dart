import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo Section
              Center(
                child: Hero(
                  tag: 'app_logo',
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.darkSurface,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.3), width: 1.5),
                    ),
                    child: Image.asset(
                      'assets/CHEESEBALL 1-KDr6TQXM.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'CHEESEBALL',
                style: GoogleFonts.outfit(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.accentGold,
                  letterSpacing: 6,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Institutional-Grade\nCrypto Exchange',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.darkTextSecondary,
                  height: 1.5,
                ),
              ),
              const Spacer(flex: 3),
              // Action Buttons
              _buildActionButton(
                context: context,
                text: 'Get Started',
                onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
                isPrimary: true,
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                context: context,
                text: 'Sign In',
                onPressed: () => Navigator.pushNamed(context, '/auth'),
                isPrimary: false,
              ),
              const SizedBox(height: 32),
              Text(
                '© 2024 Cheeseball. All rights reserved.',
                style: GoogleFonts.inter(
                  color: AppTheme.darkTextSecondary.withValues(alpha: 0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppTheme.accentGold : Colors.transparent,
          foregroundColor: isPrimary ? AppTheme.darkBg : AppTheme.accentGold,
          elevation: isPrimary ? 8 : 0,
          side: isPrimary ? BorderSide.none : const BorderSide(color: AppTheme.accentGold, width: 1.5),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}


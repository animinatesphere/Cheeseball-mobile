import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppTheme.blueGradientBR,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              children: [
                const Spacer(flex: 2),
                // Logo Section
                Center(
                  child: Hero(
                    tag: 'app_logo',
                    child: Image.asset(
                      'assets/CHEESEBALL 1-KDr6TQXM.png',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'CHEESEBALL',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.white,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Simple. Secure. Seamless.\nCrypto for Everyone.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.white.withValues(alpha: 0.8),
                    height: 1.5,
                  ),
                ),
                const Spacer(flex: 3),
                // Action Buttons
                _buildActionButton(
                  context: context,
                  text: 'Get Started',
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  isPrimary: true,
                ),
                const SizedBox(height: 16),
                _buildActionButton(
                  context: context,
                  text: 'Sign In',
                  onPressed: () => Navigator.pushNamed(context, '/auth'),
                  isPrimary: false,
                ),
                const SizedBox(height: 20),
                Text(
                  '© 2024 Cheeseball. All rights reserved.',
                  style: GoogleFonts.inter(
                    color: AppTheme.white.withValues(alpha: 0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
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
          backgroundColor: isPrimary ? AppTheme.white : Colors.transparent,
          foregroundColor: isPrimary ? AppTheme.blue600 : AppTheme.white,
          elevation: isPrimary ? 4 : 0,
          side: isPrimary ? BorderSide.none : const BorderSide(color: AppTheme.white, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}


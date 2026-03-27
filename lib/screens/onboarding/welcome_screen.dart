import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LucideIcons.arrowLeft,
                      color: AppTheme.darkText, size: 24),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          decoration: BoxDecoration(
                              color: AppTheme.darkSurface,
                              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                              border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.2))),
                          child: Text('CHEESEBALL',
                              style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.accentGold,
                                  letterSpacing: 2,
                                  fontSize: 24))),
                      const SizedBox(height: 64),
                      Text('Continue as',
                          style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.darkText)),
                      const SizedBox(height: 48),
                      _buildRoleButton(
                        context: context,
                        label: 'Standard User',
                        icon: LucideIcons.user,
                        onPressed: () => Navigator.pushNamed(context, '/auth'),
                        isPrimary: true,
                      ),
                      const SizedBox(height: 20),
                      _buildRoleButton(
                        context: context,
                        label: 'Administrator',
                        icon: LucideIcons.shield,
                        onPressed: () => Navigator.pushNamed(context, '/admin-login'),
                        isPrimary: false,
                      ),
                      const SizedBox(height: 64),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(LucideIcons.lock, size: 14, color: AppTheme.darkTextSecondary),
                          const SizedBox(width: 8),
                          Text('Secure • Fast • Reliable',
                              style: GoogleFonts.inter(
                                  color: AppTheme.darkTextSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppTheme.accentGold : AppTheme.darkSurface,
          foregroundColor: isPrimary ? AppTheme.darkBg : AppTheme.darkText,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          elevation: isPrimary ? 8 : 0,
          side: isPrimary ? BorderSide.none : const BorderSide(color: AppTheme.darkHighlight, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

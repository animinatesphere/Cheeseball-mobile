import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;
  String? _error;

  Future<void> _handleSignUp() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await SupabaseService.signUpWithPassword(
          _emailController.text.trim(), _passwordController.text.trim());
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/currency-change');
      }
    } catch (e) {
      String errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('user already exists')) {
        setState(() => _error = "Looks like you already have an account! Try signing in instead.");
      } else if (errorMessage.contains('weak password')) {
        setState(() => _error = "That password is a bit too easy to guess. Try making it a bit stronger!");
      } else if (errorMessage.contains('network') || errorMessage.contains('failed host lookup')) {
        setState(() => _error = "We're having trouble reaching our servers. Check your internet connection?");
      } else {
        setState(() => _error = "Oops! We hit a snag creating your account. Please try again.");
      }
    }
    setState(() => _loading = false);
  }

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Onboarding Icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme.darkSurface,
                          borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                          border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.2)),
                        ),
                        child: const Center(
                          child: Icon(
                            LucideIcons.rocket,
                            size: 40,
                            color: AppTheme.accentGold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Title
                      Text(
                        'Create Account',
                        style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.darkText,
                            letterSpacing: -0.5),
                      ),
                      const SizedBox(height: 12),

                      // Subtitle
                      Text(
                        'Start trading crypto with zero hassle\nJoin thousands of secure users',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppTheme.darkTextSecondary,
                            fontWeight: FontWeight.w400,
                            height: 1.5),
                      ),
                      const SizedBox(height: 40),

                      // Email input
                      _buildLabel('EMAIL ADDRESS'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'name@example.com',
                          prefixIcon: Icon(LucideIcons.mail,
                              color: AppTheme.darkTextSecondary, size: 20),
                        ),
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkText),
                      ),
                      const SizedBox(height: 24),

                      // Password input
                      _buildLabel('PASSWORD'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(LucideIcons.lock,
                              color: AppTheme.darkTextSecondary, size: 20),
                          suffixIcon: GestureDetector(
                            onTap: () => setState(() =>
                                _obscurePassword = !_obscurePassword),
                            child: Icon(
                                _obscurePassword
                                    ? LucideIcons.eyeOff
                                    : LucideIcons.eye,
                                color: AppTheme.darkTextSecondary,
                                size: 20),
                          ),
                        ),
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.darkText),
                      ),

                      // Benefits
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.darkCard,
                          borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                          border: Border.all(color: AppTheme.darkHighlight),
                        ),
                        child: Column(
                          children: [
                            _benefitRow(
                                LucideIcons.shieldCheck,
                                'Bank-level Security',
                                'Your funds and data are protected'),
                            const SizedBox(height: 12),
                            const Divider(color: AppTheme.darkHighlight, height: 1),
                            const SizedBox(height: 12),
                            _benefitRow(
                                LucideIcons.zap,
                                'Instant Transactions',
                                'No delays, no hidden fees'),
                          ],
                        ),
                      ),

                      // Error
                      if (_error != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppTheme.red500.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                              border:
                                  Border.all(color: AppTheme.red500.withValues(alpha: 0.2))),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.alertCircle, color: AppTheme.red500, size: 18),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: Text(_error!,
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.red500))),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 40),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _handleSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentGold,
                            foregroundColor: AppTheme.darkBg,
                            disabledBackgroundColor: AppTheme.darkHighlight,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppTheme.radiusSM)),
                          ),
                          child: _loading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                      color: AppTheme.darkBg, strokeWidth: 3))
                              : Text('Get Started',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Sign In Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.darkTextSecondary)),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, '/auth'),
                            child: Text('Sign In',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.accentGold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text('SECURED BY SUPABASE INFRASTRUCTURE',
                          style: AppTheme.labelXS.copyWith(color: AppTheme.darkTextSecondary, fontSize: 10)),
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

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: AppTheme.labelXS.copyWith(
          color: AppTheme.darkTextSecondary,
          letterSpacing: 1.2,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _benefitRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.15)),
          ),
          child: Center(
            child: Icon(icon, size: 18, color: AppTheme.accentGold),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppTheme.darkText)),
              Text(subtitle,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppTheme.darkTextSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}

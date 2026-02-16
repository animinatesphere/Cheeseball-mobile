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
  final _otpController = TextEditingController();
  bool _loading = false;
  String _step = 'email'; // 'email' or 'otp'
  String? _error;

  Future<void> _handleSendOtp() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await SupabaseService.signInWithOtp(_emailController.text.trim());
      setState(() => _step = 'otp');
    } catch (e) {
      setState(() => _error = e.toString());
    }
    setState(() => _loading = false);
  }

  Future<void> _handleVerifyOtp() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await SupabaseService.verifyOtp(
          _emailController.text.trim(), _otpController.text.trim());
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/currency-change');
      }
    } catch (e) {
      setState(() => _error = e.toString());
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                      color: AppTheme.blue100,
                      blurRadius: 32,
                      offset: Offset(0, 12))
                ],
                border: Border.all(color: AppTheme.blue50),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Onboarding Image Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.blue50,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: AppTheme.blue100,
                          blurRadius: 24,
                          offset: Offset(0, 8),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        LucideIcons.rocket,
                        size: 48,
                        color: AppTheme.blue600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Logo
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: AppTheme.blue50,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text('CHEESEBALL',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w900,
                            color: AppTheme.primaryBlue,
                            fontSize: 20)),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    _step == 'email' ? 'Secure Signup' : 'Verify Identity',
                    style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.gray900,
                        letterSpacing: -0.3),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle
                  Text(
                    _step == 'email'
                        ? 'Start trading crypto with zero hassle\nJoin thousands of secure users'
                        : 'We\'ve sent a secure code to ${_emailController.text}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppTheme.gray500,
                        fontWeight: FontWeight.w500,
                        height: 1.5),
                  ),
                  const SizedBox(height: 40),

                  // Email or OTP input
                  if (_step == 'email') ...[
                    Text('EMAIL ADDRESS', style: AppTheme.labelXS),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'name@example.com',
                        prefixIcon: const Icon(LucideIcons.mail,
                            color: AppTheme.gray400, size: 20),
                        filled: true,
                        fillColor: AppTheme.gray50,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: AppTheme.blue100, width: 2)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                      ),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700, color: AppTheme.gray900),
                    ),
                  ] else ...[
                    Text('SECURITY CODE', style: AppTheme.labelXS),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 8,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '0 0 0 0 0 0 0 0',
                        prefixIcon: const Icon(LucideIcons.keyRound,
                            color: AppTheme.gray400, size: 20),
                        counterText: '',
                        filled: true,
                        fillColor: AppTheme.gray50,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: AppTheme.blue100, width: 2)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                      ),
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: 8,
                          color: AppTheme.gray900),
                    ),
                  ],

                  // Benefits (only on first step)
                  if (_step == 'email') ...[
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.blue50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.blue100),
                      ),
                      child: Column(
                        children: [
                          _benefitRow(
                              LucideIcons.shieldCheck,
                              'Bank-level Security',
                              'Your funds and data are protected'),
                          const SizedBox(height: 12),
                          const Divider(color: AppTheme.blue100),
                          const SizedBox(height: 12),
                          _benefitRow(LucideIcons.zap, 'Instant Transactions',
                              'No delays, no hidden fees'),
                          const SizedBox(height: 12),
                          const Divider(color: AppTheme.blue100),
                          const SizedBox(height: 12),
                          _benefitRow(LucideIcons.globe, 'Global Access',
                              'Trade from anywhere, anytime'),
                        ],
                      ),
                    ),
                  ],

                  // Error
                  if (_error != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppTheme.red50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFEE2E2))),
                      child: Row(
                        children: [
                          Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                  color: AppTheme.red500,
                                  shape: BoxShape.circle)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Text(_error!,
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.red600))),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading
                          ? null
                          : (_step == 'email'
                              ? _handleSendOtp
                              : _handleVerifyOtp),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.blue600,
                        disabledBackgroundColor: AppTheme.blue200,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 8,
                        shadowColor: AppTheme.blue200,
                      ),
                      child: _loading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                  color: AppTheme.white, strokeWidth: 3))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    _step == 'email'
                                        ? 'Send Access Code'
                                        : 'Verify & Create Account',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: AppTheme.white)),
                                const SizedBox(width: 8),
                                const Icon(LucideIcons.arrowRight,
                                    size: 18, color: AppTheme.white),
                              ],
                            ),
                    ),
                  ),

                  if (_step == 'otp') ...[
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => setState(() => _step = 'email'),
                      child: Text('CHANGE EMAIL',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              letterSpacing: 2,
                              color: AppTheme.blue600)),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // Sign In Link
                  if (_step == 'email') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                color: AppTheme.gray600)),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushReplacementNamed(context, '/auth'),
                          child: Text('Sign In',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.blue600)),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 28),
                  const Divider(color: AppTheme.gray50),
                  const SizedBox(height: 16),
                  Text('SECURED BY SUPABASE INFRASTRUCTURE',
                      style: AppTheme.labelXS),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _benefitRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.blue600,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(icon, size: 20, color: AppTheme.white),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      color: AppTheme.gray900)),
              Text(subtitle,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                      color: AppTheme.gray500)),
            ],
          ),
        ),
      ],
    );
  }
}

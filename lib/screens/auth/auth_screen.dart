import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
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
                  const SizedBox(height: 40),
                  // Title
                  Text(
                    _step == 'email' ? 'Secure Login' : 'Verify Identity',
                    style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.gray900,
                        letterSpacing: -0.3),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _step == 'email'
                        ? 'Enter your email to receive a secure access code'
                        : 'We\'ve sent a secure code to ${_emailController.text}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppTheme.gray500,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 32),

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

                  const SizedBox(height: 24),

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
                                        : 'Verify & Sign In',
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

                  const SizedBox(height: 32),
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
}

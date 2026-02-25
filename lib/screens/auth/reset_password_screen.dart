import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;
  String? _message;

  Future<void> _handleReset() async {
    if (_otpController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      setState(() => _error = 'Please fill in both fields');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _message = null;
    });

    try {
      // 1. Verify OTP
      await SupabaseService.verifyResetOtp(widget.email, _otpController.text.trim());
      
      // 2. Update Password
      await SupabaseService.updatePassword(_passwordController.text.trim());
      
      setState(() => _message = "Success! Your password has been updated.");
      
      if (mounted) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
          }
        });
      }
    } catch (e) {
      setState(() => _error = "Hmm, that code didn't work. Check it and try again?");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
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
                      color: AppTheme.gray900, size: 24),
                ),
              ),
            ),
            Expanded(
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
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: AppTheme.blue50,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(LucideIcons.shieldCheck,
                              color: AppTheme.blue600, size: 32),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Set New Password',
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.gray900),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "We've sent a code to ${widget.email}. Enter it below along with your new password.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: AppTheme.gray500,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 32),
                        // OTP Input
                        Text('VERIFICATION CODE', style: AppTheme.labelXS),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter 6-digit code',
                            prefixIcon: const Icon(LucideIcons.hash,
                                color: AppTheme.gray400, size: 20),
                            filled: true,
                            fillColor: AppTheme.gray50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none),
                          ),
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.gray900),
                        ),
                        const SizedBox(height: 20),
                        // Password input
                        Text('NEW PASSWORD', style: AppTheme.labelXS),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter new password',
                            prefixIcon: const Icon(LucideIcons.lock,
                                color: AppTheme.gray400, size: 20),
                            filled: true,
                            fillColor: AppTheme.gray50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none),
                          ),
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.gray900),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 16),
                          Text(_error!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  color: AppTheme.red500,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)),
                        ],
                        if (_message != null) ...[
                          const SizedBox(height: 16),
                          Text(_message!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  color: AppTheme.blue600,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)),
                        ],
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _handleReset,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.blue600,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                            child: _loading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                        color: AppTheme.white, strokeWidth: 3))
                                : Text('Update Password',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: AppTheme.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

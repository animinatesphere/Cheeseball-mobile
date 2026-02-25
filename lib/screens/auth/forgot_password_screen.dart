import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _loading = false;
  String? _error;
  String? _message;

  Future<void> _handleReset() async {
    if (_emailController.text.trim().isEmpty) {
      setState(() => _error = 'Please enter your email address');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _message = null;
    });

    try {
      await SupabaseService.resetPasswordForEmail(_emailController.text.trim());
      setState(() => _message = "Got it! Check your inbox for the reset code.");
      if (mounted) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushNamed(
              context, 
              '/reset-password',
              arguments: _emailController.text.trim(),
            );
          }
        });
      }
    } catch (e) {
      setState(() => _error = "Oops! We couldn't find that email. Try again?");
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
                          child: const Icon(LucideIcons.key,
                              color: AppTheme.blue600, size: 32),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Forgot Password?',
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.gray900),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "No worries! Enter your email and we'll send you a code to reset it.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: AppTheme.gray500,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 32),
                        // Email input
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(LucideIcons.mail,
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
                                : Text('Send Reset Code',
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

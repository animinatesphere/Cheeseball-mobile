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
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;
  String? _error;

  Future<void> _handleSignIn() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await SupabaseService.signInWithPassword(
          _emailController.text.trim(), _passwordController.text.trim());
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/currency-change');
      }
    } catch (e) {
      String errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('invalid login credentials')) {
        setState(() => _error = "Hmm, those details don't match. Check your email or password and try again!");
      } else if (errorMessage.contains('network') || errorMessage.contains('failed host lookup')) {
        setState(() => _error = "We're having trouble reaching our servers. Check your internet connection?");
      } else {
        setState(() => _error = "Oops! Something went wrong on our end. Please try again in a bit.");
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
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Hero(
                        tag: 'app_logo',
                        child: Image.asset(
                          'assets/CHEESEBALL 1-KDr6TQXM.png',
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Title
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.darkText,
                            letterSpacing: -0.5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Secure login to your Cheeseball account',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppTheme.darkTextSecondary,
                            fontWeight: FontWeight.w400),
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
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, '/forgot-password'),
                          child: Text('Forgot Password?',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.accentGold)),
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

                      const SizedBox(height: 48),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _handleSignIn,
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
                              : Text('Sign In',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                        ),
                      ),

                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New to Cheeseball? ",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.darkTextSecondary)),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/signup'),
                            child: Text('Register',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.accentGold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
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
}

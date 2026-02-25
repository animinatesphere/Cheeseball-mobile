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
                        // Logo
                        Image.asset(
                          'assets/CHEESEBALL 1-KDr6TQXM.png',
                          height: 48,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 40),
                        // Title
                        Text(
                          'Secure Login',
                          style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.gray900,
                              letterSpacing: -0.3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter your credentials to access your account',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppTheme.gray500,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 32),

                        // Email input
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
                              fontWeight: FontWeight.w700,
                              color: AppTheme.gray900),
                        ),
                        const SizedBox(height: 20),

                        // Password input
                        Text('PASSWORD', style: AppTheme.labelXS),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(LucideIcons.lock,
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
                              fontWeight: FontWeight.w700,
                              color: AppTheme.gray900),
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
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.blue600)),
                          ),
                        ),

                        // Error
                        if (_error != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: AppTheme.red50,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xFFFEE2E2))),
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
                            onPressed: _loading ? null : _handleSignIn,
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
                                      Text('Sign In',
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

                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.gray600)),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/signup'),
                              child: Text('Create Account',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.blue600)),
                            ),
                          ],
                        ),
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
          ],
        ),
      ),
    );
  }
}

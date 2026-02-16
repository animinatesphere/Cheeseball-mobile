import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

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
                            ]),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  color: AppTheme.blue50,
                                  shape: BoxShape.circle),
                              child: const Icon(LucideIcons.shield,
                                  color: AppTheme.blue600, size: 32)),
                          const SizedBox(height: 24),
                          Text('Admin Portal',
                              style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.gray900)),
                          const SizedBox(height: 8),
                          Text('Restricted access only',
                              style: GoogleFonts.inter(
                                  color: AppTheme.gray400,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 32),
                          TextField(
                              controller: _emailCtrl,
                              decoration: const InputDecoration(
                                  hintText: 'Admin Email',
                                  prefixIcon: Icon(LucideIcons.mail,
                                      color: AppTheme.gray400))),
                          const SizedBox(height: 12),
                          TextField(
                              controller: _passCtrl,
                              obscureText: _obscure,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: const Icon(LucideIcons.lock,
                                      color: AppTheme.gray400),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                          _obscure
                                              ? LucideIcons.eyeOff
                                              : LucideIcons.eye,
                                          color: AppTheme.gray400),
                                      onPressed: () => setState(
                                          () => _obscure = !_obscure)))),
                          const SizedBox(height: 24),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, '/admin-dashboard'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primaryBlue,
                                      foregroundColor: AppTheme.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  child: Text('Sign In',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16)))),
                          const SizedBox(height: 24),
                          Text('CHEESEBALL ADMIN', style: AppTheme.labelXS),
                        ]))))));
  }
}

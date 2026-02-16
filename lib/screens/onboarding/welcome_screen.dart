import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(
                        color: AppTheme.blue100,
                        blurRadius: 32,
                        offset: Offset(0, 12))
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                          color: AppTheme.blue50,
                          borderRadius: BorderRadius.circular(16)),
                      child: Text('CHEESEBALL',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w900,
                              color: AppTheme.primaryBlue,
                              fontSize: 22))),
                  const SizedBox(height: 48),
                  Text('Log in as',
                      style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.gray800)),
                  const SizedBox(height: 48),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/auth'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 8,
                              shadowColor: AppTheme.blue200),
                          child: Text('User',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppTheme.white)))),
                  const SizedBox(height: 12),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/admin-login'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.gray100,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 0),
                          child: Text('Admin',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppTheme.primaryBlue)))),
                  const SizedBox(height: 48),
                  Text('Secure • Fast • Reliable',
                      style: GoogleFonts.inter(
                          color: AppTheme.gray400,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

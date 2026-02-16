import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/welcome'),
                  child: Text('Skip',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primaryBlue,
                          fontSize: 16)),
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                    color: AppTheme.blue50,
                    borderRadius: BorderRadius.circular(16)),
                child: Text('CHEESEBALL',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primaryBlue,
                        fontSize: 22)),
              ),
              const SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.gray900,
                      height: 1.2),
                  children: const [
                    TextSpan(text: 'BUY, SELL &\n'),
                    TextSpan(
                        text: 'SWAP CRYPTO',
                        style: TextStyle(color: AppTheme.primaryBlue)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'The most secure and seamless way to manage your digital assets. Join thousands of users trading on Cheeseball today.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppTheme.gray600,
                    fontWeight: FontWeight.w500,
                    height: 1.6),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/welcome'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    elevation: 8,
                    shadowColor: AppTheme.blue200,
                  ),
                  child: Text('Get started',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppTheme.white)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

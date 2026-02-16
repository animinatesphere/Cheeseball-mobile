import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  final int activeIndex;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final Function(int) onDot;
  const IntroPage(
      {super.key,
      required this.title,
      required this.description,
      required this.activeIndex,
      required this.onSkip,
      required this.onNext,
      required this.onDot});
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
                      onPressed: onSkip,
                      child: Text('Skip',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryBlue,
                              fontSize: 16)))),
              const Spacer(),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppTheme.blue50,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text('CHEESEBALL',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          color: AppTheme.primaryBlue,
                          fontSize: 18))),
              const SizedBox(height: 32),
              Text(title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.gray900,
                      letterSpacing: -0.5)),
              const SizedBox(height: 16),
              Text(description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      color: AppTheme.gray600,
                      fontWeight: FontWeight.w500,
                      height: 1.6)),
              const Spacer(),
              Row(children: [
                ...List.generate(
                    3,
                    (i) => GestureDetector(
                        onTap: () => onDot(i),
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: i == activeIndex ? 40 : 12,
                            height: 8,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                                color: i == activeIndex
                                    ? AppTheme.primaryBlue
                                    : AppTheme.gray200,
                                borderRadius: BorderRadius.circular(4))))),
                const SizedBox(width: 12),
                GestureDetector(
                    onTap: onNext,
                    child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                            color: AppTheme.primaryBlue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: AppTheme.blue200,
                                  blurRadius: 12,
                                  offset: Offset(0, 4))
                            ]),
                        child: const Icon(LucideIcons.arrowRight,
                            color: AppTheme.white, size: 22))),
              ]),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

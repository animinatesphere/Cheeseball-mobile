import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PaymentSuccessModal extends StatelessWidget {
  final VoidCallback onClose;
  const PaymentSuccessModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black54,
        child: Center(
            child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: AppTheme.green50,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: AppTheme.green500.withValues(alpha: 0.2),
                                blurRadius: 24)
                          ]),
                      child: const Icon(LucideIcons.checkCircle,
                          color: AppTheme.green600, size: 40)),
                  const SizedBox(height: 24),
                  Text('Payment Successful!',
                      style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.gray900)),
                  const SizedBox(height: 12),
                  Text(
                      'Your transaction has been completed. Your crypto will be delivered to the provided address shortly.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppTheme.gray500,
                          fontWeight: FontWeight.w500,
                          height: 1.6)),
                  const SizedBox(height: 32),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: onClose,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              foregroundColor: AppTheme.white,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24))),
                          child: Text('Back to Market',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900, fontSize: 16)))),
                ]))));
  }
}

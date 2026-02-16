import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CryptoExchangeModal extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onClose;
  const CryptoExchangeModal(
      {super.key, required this.onAccept, required this.onClose});

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
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue50, shape: BoxShape.circle),
                      child: const Icon(LucideIcons.shield,
                          color: AppTheme.blue600, size: 28)),
                  const SizedBox(height: 24),
                  Text('Terms of Exchange',
                      style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.gray900)),
                  const SizedBox(height: 12),
                  Text(
                      'By proceeding, you agree to our exchange terms and conditions. Cryptocurrency transactions are irreversible once confirmed.',
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
                          onPressed: onAccept,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              foregroundColor: AppTheme.white,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24))),
                          child: Text('Accept & Continue',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900, fontSize: 16)))),
                  const SizedBox(height: 12),
                  TextButton(
                      onPressed: onClose,
                      child: Text('Cancel',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.gray400))),
                ]))));
  }
}

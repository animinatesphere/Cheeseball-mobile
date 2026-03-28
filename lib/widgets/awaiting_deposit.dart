import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';
// import 'dart:math';

class AwaitingDeposit extends StatelessWidget {
  final Map<String, dynamic>? transactionData;
  final VoidCallback onBack;
  const AwaitingDeposit(
      {super.key, this.transactionData, required this.onBack});

  @override
  Widget build(BuildContext context) {
    if (transactionData == null) {
      return const SizedBox();
    }
    final td = transactionData!;
    const addr = 'bc1qxy2kgdyqrrejb5hx';
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text('Deposit Crypto',
            style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: onBack,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Swap summary card
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: AppTheme.goldGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                  boxShadow: AppTheme.shadowMD,
                ),
                child: Column(
                  children: [
                    Text('SWAP INTENT',
                        style: AppTheme.labelXS.copyWith(
                            color: AppTheme.darkBg.withValues(alpha: 0.6))),
                    const SizedBox(height: 16),
                    Text('${td['fromAmount']} ${td['fromCurrency']}',
                        style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.darkBg)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.darkBg.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Status: Pending',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.darkBg)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Expected return
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.darkCard,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                  border: Border.all(color: AppTheme.darkHighlight),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.accentGold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(LucideIcons.coins,
                          color: AppTheme.accentGold, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('EXPECTED RETURN',
                            style: AppTheme.labelXS
                                .copyWith(color: AppTheme.darkTextSecondary)),
                        Text('${td['toAmount']} ${td['toCurrency']}',
                            style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkText)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // QR + Address area
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                  border: Border.all(color: AppTheme.darkHighlight),
                ),
                child: Column(
                  children: [
                    Text('DEPOSIT ADDRESS',
                        style: AppTheme.labelXS
                            .copyWith(color: AppTheme.darkTextSecondary)),
                    const SizedBox(height: 24),
                    // Mock QR (Placeholder for real QR widget)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(LucideIcons.qrCode,
                          size: 160, color: Colors.black),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.darkBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.darkHighlight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('WALLET ADDRESS',
                              style: AppTheme.labelXS.copyWith(
                                  color: AppTheme.darkTextSecondary,
                                  fontSize: 9)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text(addr,
                                    style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkText)),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                      const ClipboardData(text: addr));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Address copied!")));
                                },
                                child: const Icon(LucideIcons.copy,
                                    color: AppTheme.accentGold, size: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onBack,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentGold,
                          foregroundColor: AppTheme.darkBg,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        child: Text('I Have Sent the Funds',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

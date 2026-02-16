import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';
import 'dart:math';

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
    const addr = '0x52d39886F8022764880Fff88DdE280F6C5D3CcD';
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          decoration: const BoxDecoration(gradient: AppTheme.blueGradient),
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                  onTap: onBack,
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Icon(LucideIcons.arrowLeft,
                          color: AppTheme.white))),
              Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(16)),
                  child: const Icon(LucideIcons.share2, color: AppTheme.white)),
            ]),
            const SizedBox(height: 16),
            Text('Deposit Funds',
                style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.white)),
            Text('Finalize your swap by sending assets',
                style: GoogleFonts.inter(color: AppTheme.blue200)),
          ])),
      Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            // Swap summary
            Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                    color: AppTheme.blue600,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: AppTheme.shadowBlue),
                child: Column(children: [
                  Text('SWAP INTENT',
                      style:
                          AppTheme.labelXS.copyWith(color: AppTheme.blue200)),
                  const SizedBox(height: 16),
                  Text('${td['fromAmount']} ${td['fromCurrency']}',
                      style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.white)),
                  const SizedBox(height: 8),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Status: Pending',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.green[300]))),
                ])),
            const SizedBox(height: 16),
            // Expected return
            Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: AppTheme.gray50,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppTheme.gray100)),
                child: Row(children: [
                  Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: AppTheme.orange600,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                          child: Text('₿',
                              style: GoogleFonts.inter(
                                  color: AppTheme.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24)))),
                  const SizedBox(width: 16),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('EXPECTED RETURN', style: AppTheme.labelXS),
                        Text('${td['toAmount']} ${td['toCurrency']}',
                            style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: AppTheme.gray900))
                      ]),
                ])),
            const SizedBox(height: 24),
            // QR + Address
            Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppTheme.gray100),
                    boxShadow: AppTheme.shadowMD),
                child: Column(children: [
                  Text('DEPOSIT ADDRESS', style: AppTheme.labelXS),
                  const SizedBox(height: 24),
                  // Mock QR
                  Container(
                      width: 200,
                      height: 200,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppTheme.gray50,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                              color: AppTheme.gray200,
                              style: BorderStyle.solid,
                              width: 2)),
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 8,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2),
                          itemCount: 64,
                          itemBuilder: (_, i) => Container(
                              decoration: BoxDecoration(
                                  color: Random(i).nextBool()
                                      ? AppTheme.gray900
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(1))))),
                  const SizedBox(height: 24),
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppTheme.gray50,
                          borderRadius: BorderRadius.circular(24)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('WALLET ADDRESS', style: AppTheme.labelXS),
                            const SizedBox(height: 8),
                            Text(addr,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.gray900,
                                    fontFeatures: const [
                                      FontFeature.tabularFigures()
                                    ])),
                          ])),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(const ClipboardData(text: addr));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Copied!')));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              foregroundColor: AppTheme.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Copy',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16)),
                                const SizedBox(width: 8),
                                const Icon(LucideIcons.copy, size: 18)
                              ]))),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: onBack,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              foregroundColor: AppTheme.white,
                              padding: const EdgeInsets.symmetric(vertical: 22),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Verify & Complete',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18)),
                                const SizedBox(width: 8),
                                const Icon(LucideIcons.arrowRight, size: 20)
                              ]))),
                ])),
          ])),
    ]));
  }
}

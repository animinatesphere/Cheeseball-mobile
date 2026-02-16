import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';

class BankTransferDetails extends StatelessWidget {
  final Map<String, dynamic>? transactionData;
  final VoidCallback onBack;
  final VoidCallback onContinue;
  const BankTransferDetails({super.key, this.transactionData, required this.onBack, required this.onContinue});

  @override Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      Container(decoration: const BoxDecoration(gradient: AppTheme.blueGradient), padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(onTap: onBack, child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(16)), child: const Icon(LucideIcons.arrowLeft, color: AppTheme.white))),
          const SizedBox(height: 16),
          Text('Bank Transfer', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.white)),
          Text('Complete your payment via bank transfer', style: GoogleFonts.inter(color: AppTheme.blue200)),
        ])),
      Padding(padding: const EdgeInsets.all(24), child: Column(children: [
        Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(40), border: Border.all(color: AppTheme.gray100), boxShadow: AppTheme.shadowMD),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('TRANSFER DETAILS', style: AppTheme.labelXS), const SizedBox(height: 24),
            _detail('Bank Name', 'Paystack-Titan', LucideIcons.building),
            _detail('Account Number', '0123456789', LucideIcons.hash),
            _detail('Account Name', 'Cheeseball Exchange', LucideIcons.user),
            _detail('Amount', '${transactionData?['fromAmount'] ?? '0'} ${transactionData?['fromCurrency'] ?? 'NGN'}', LucideIcons.banknote),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.orange50, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFFED7AA))),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(LucideIcons.alertCircle, color: AppTheme.orange600, size: 18), const SizedBox(width: 12),
                Expanded(child: Text('This account number is unique to this transaction. Do not save or reuse for future transactions.', style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF9A3412), fontWeight: FontWeight.w500))),
              ])),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onContinue,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue, foregroundColor: AppTheme.white, padding: const EdgeInsets.symmetric(vertical: 22), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("I've Made the Transfer", style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 18)), const SizedBox(width: 8), const Icon(LucideIcons.arrowRight, size: 20)]))),
          ])),
      ])),
    ]));
  }

  Widget _detail(String label, String value, IconData icon) => Container(
    margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: AppTheme.gray50, borderRadius: BorderRadius.circular(24)),
    child: Row(children: [
      Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.blue50, borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppTheme.blue600, size: 20)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label.toUpperCase(), style: AppTheme.labelXS.copyWith(fontSize: 9)),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900, color: AppTheme.gray900)),
      ])),
      Builder(builder: (ctx) => GestureDetector(onTap: () { Clipboard.setData(ClipboardData(text: value)); ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('Copied!'))); }, child: const Icon(LucideIcons.copy, color: AppTheme.blue600, size: 18))),
    ]),
  );
}

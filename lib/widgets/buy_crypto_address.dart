import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';

class BuyCryptoAddress extends StatefulWidget {
  final Map<String, dynamic>? transactionData;
  final VoidCallback onBack;
  final Function(String) onCreateExchange;
  const BuyCryptoAddress({super.key, this.transactionData, required this.onBack, required this.onCreateExchange});
  @override State<BuyCryptoAddress> createState() => _BuyCryptoAddressState();
}
class _BuyCryptoAddressState extends State<BuyCryptoAddress> {
  final _ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final td = widget.transactionData ?? {};
    return SingleChildScrollView(child: Column(children: [
      Container(decoration: const BoxDecoration(gradient: AppTheme.blueGradient), padding: const EdgeInsets.fromLTRB(24, 48, 24, 32), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(onTap: widget.onBack, child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(16)), child: const Icon(LucideIcons.arrowLeft, color: AppTheme.white))),
        const SizedBox(height: 16), Text('Delivery Address', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.white)), Text('Where should we send your assets?', style: GoogleFonts.inter(color: AppTheme.blue200)),
      ])),
      Padding(padding: const EdgeInsets.all(24), child: Column(children: [
        Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: AppTheme.blue600, borderRadius: BorderRadius.circular(40), boxShadow: AppTheme.shadowBlue),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('YOU PAY', style: AppTheme.labelXS.copyWith(color: AppTheme.blue200)), Text('${td['fromAmount'] ?? '0'} ${td['fromCurrency'] ?? 'NGN'}', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: AppTheme.white))]),
            const Icon(LucideIcons.arrowRight, color: AppTheme.blue200),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('YOU GET', style: AppTheme.labelXS.copyWith(color: AppTheme.blue200)), Text('${td['toAmount'] ?? '0'} ${td['toCurrency'] ?? 'BTC'}', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w900, color: AppTheme.white))]),
          ])),
        const SizedBox(height: 24),
        Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(color: AppTheme.white, borderRadius: BorderRadius.circular(40), border: Border.all(color: AppTheme.gray100), boxShadow: AppTheme.shadowLG),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Recipient Address', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w900, color: AppTheme.gray900)),
            const SizedBox(height: 24),
            Text('${td['toCurrency'] ?? 'Bitcoin'} ADDRESS', style: AppTheme.labelXS), const SizedBox(height: 12),
            TextField(controller: _ctrl, decoration: InputDecoration(hintText: 'Enter ${td['toCurrency'] ?? '₿'} address here...', suffixIcon: IconButton(icon: const Icon(LucideIcons.clipboard, color: AppTheme.primaryBlue), onPressed: () async { final d = await Clipboard.getData('text/plain'); if (d?.text != null) _ctrl.text = d!.text!; }))),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppTheme.orange50, borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFFFED7AA))),
              child: Row(children: [const Icon(LucideIcons.alertCircle, color: AppTheme.orange600, size: 18), const SizedBox(width: 12), Expanded(child: Text('Please ensure the recipient address is correct. Cryptocurrency transfers are irreversible.', style: GoogleFonts.inter(fontSize: 11, color: const Color(0xFF9A3412), fontWeight: FontWeight.w500)))])),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _ctrl.text.isEmpty ? null : () => widget.onCreateExchange(_ctrl.text),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue, foregroundColor: AppTheme.white, padding: const EdgeInsets.symmetric(vertical: 22), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)), disabledBackgroundColor: AppTheme.blue200),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Create Order', style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 18)), const SizedBox(width: 8), const Icon(LucideIcons.arrowRight, size: 20)]))),
          ])),
      ])),
    ]));
  }
}

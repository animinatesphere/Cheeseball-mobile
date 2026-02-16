import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class ConfirmSwap extends StatefulWidget {
  final Map<String, dynamic>? transactionData;
  final VoidCallback onBack;
  final VoidCallback onConfirm;
  const ConfirmSwap(
      {super.key,
      this.transactionData,
      required this.onBack,
      required this.onConfirm});
  @override
  State<ConfirmSwap> createState() => _ConfirmSwapState();
}

class _ConfirmSwapState extends State<ConfirmSwap> {
  final _addressCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _handleConfirm() async {
    if (widget.transactionData == null) {
      return;
    }
    setState(() => _loading = true);
    try {
      final user = SupabaseService.currentUser;
      if (user == null) {
        setState(() => _loading = false);
        return;
      }
      final exchangeId = 'ID:${Random().nextInt(99999999).toRadixString(36)}';
      await SupabaseService.createTransaction({
        'user_id': user.id,
        'exchange_id': exchangeId,
        'type': widget.transactionData!['type'] ?? 'swap',
        'status': 'waiting',
        'from_amount': widget.transactionData!['fromAmount'],
        'from_currency_id': widget.transactionData!['fromCurrencyId'],
        'from_token_network': widget.transactionData!['fromCurrency'],
        'to_amount': widget.transactionData!['toAmount'],
        'to_currency_id': widget.transactionData!['toCurrencyId'],
        'to_token_network': widget.transactionData!['toCurrency'],
        'wallet_address': _addressCtrl.text,
        'created_at': DateTime.now().toIso8601String(),
      });
      widget.onConfirm();
    } catch (e) {
      // Error handled silently
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final td = widget.transactionData;
    if (td == null) {
      return const SizedBox();
    }
    return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 32),
          GestureDetector(
              onTap: widget.onBack,
              child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.gray100)),
                  child: const Icon(LucideIcons.arrowLeft,
                      color: AppTheme.gray900))),
          const SizedBox(height: 24),
          Text('Confirm Swap', style: AppTheme.headingLG),
          Text('Verify your transaction details', style: AppTheme.bodySM),
          const SizedBox(height: 24),
          // Summary card
          Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: AppTheme.gray50,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: AppTheme.gray100)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SEND', style: AppTheme.labelXS),
                          const SizedBox(height: 4),
                          Text('${td['fromAmount']} ${td['fromCurrency']}',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.gray900))
                        ]),
                    const Icon(LucideIcons.arrowRight, color: AppTheme.blue600),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('RECEIVE', style: AppTheme.labelXS),
                          const SizedBox(height: 4),
                          Text('${td['toAmount']} ${td['toCurrency']}',
                              style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.gray900))
                        ]),
                  ])),
          const SizedBox(height: 24),
          Text('RECIPIENT ${td['toCurrency']} ADDRESS',
              style: AppTheme.labelXS),
          const SizedBox(height: 12),
          TextField(
              controller: _addressCtrl,
              decoration: InputDecoration(
                  hintText: 'Enter ${td['toCurrency']} address...',
                  suffixIcon: IconButton(
                      icon: const Icon(LucideIcons.clipboard,
                          color: AppTheme.primaryBlue),
                      onPressed: () async {
                        final d = await Clipboard.getData('text/plain');
                        if (d?.text != null) _addressCtrl.text = d!.text!;
                      }))),
          const SizedBox(height: 8),
          Text(
              'Carefully check the address. Transactions on the blockchain are irreversible.',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppTheme.gray400,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 24),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _loading || _addressCtrl.text.isEmpty
                      ? null
                      : _handleConfirm,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: AppTheme.white,
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      disabledBackgroundColor: AppTheme.blue200),
                  child: _loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              color: AppTheme.white, strokeWidth: 3))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text('Confirm & Swap',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18)),
                              const SizedBox(width: 8),
                              const Icon(LucideIcons.arrowRight, size: 20)
                            ]))),
        ]));
  }
}

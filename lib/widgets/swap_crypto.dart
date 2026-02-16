import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SwapCrypto extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Map<String, dynamic>) onSwap;
  final Function(String) onNavigate;
  const SwapCrypto(
      {super.key,
      required this.onBack,
      required this.onSwap,
      required this.onNavigate});
  @override
  State<SwapCrypto> createState() => _SwapCryptoState();
}

class _SwapCryptoState extends State<SwapCrypto> {
  final _fromCtrl = TextEditingController();
  final _toCtrl = TextEditingController();
  List<Map<String, dynamic>> _currencies = [];
  String _fromCurrency = 'USDT';
  String _toCurrency = 'BTC';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() => _loading = true);
    final data = await SupabaseService.getCurrencies();
    // Deduplicate by symbol
    final seen = <String>{};
    final deduped = data.where((c) {
      final sym = c['symbol'] as String?;
      if (sym == null || seen.contains(sym)) return false;
      seen.add(sym);
      return true;
    }).toList();
    setState(() {
      _currencies = deduped;
      // Set to first currency if exists, otherwise keep defaults
      if (deduped.isNotEmpty) {
        _fromCurrency = deduped[0]['symbol'] as String? ?? 'USDT';
        _toCurrency = deduped.length > 1
            ? deduped[1]['symbol'] as String? ?? 'BTC'
            : deduped[0]['symbol'] as String? ?? 'BTC';
      }
      _loading = false;
    });
  }

  double _getPrice(String symbol) {
    if (['USDT', 'USDC'].contains(symbol)) {
      return 1;
    }
    final c =
        _currencies.firstWhere((c) => c['symbol'] == symbol, orElse: () => {});
    return double.tryParse(c['price']?.toString() ?? '0') ?? 0;
  }

  void _calcTo() {
    final val = double.tryParse(_fromCtrl.text);
    if (val == null) {
      _toCtrl.text = '';
      return;
    }
    final fp = _getPrice(_fromCurrency), tp = _getPrice(_toCurrency);
    if (fp > 0 && tp > 0) _toCtrl.text = (val * fp / tp).toStringAsFixed(6);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _currencies.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: AppTheme.blue600));
    }
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          decoration: const BoxDecoration(gradient: AppTheme.blueGradient),
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
                onTap: widget.onBack,
                child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10)),
                    child: const Icon(LucideIcons.arrowLeft,
                        color: AppTheme.white))),
            const SizedBox(height: 16),
            Text('Swap Assets',
                style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.white)),
            Text('Instant conversion with zero slippage',
                style: GoogleFonts.inter(
                    color: AppTheme.blue200, fontWeight: FontWeight.w500)),
          ])),
      Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            // Tab
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppTheme.shadowMD,
                    border: Border.all(color: AppTheme.gray100)),
                child: Row(children: [
                  Expanded(
                      child: GestureDetector(
                          onTap: () => widget.onNavigate('buy'),
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text('Buy/Sell',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.gray500))))),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                              color: AppTheme.blue600,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('Swap',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.white)))),
                ])),
            const SizedBox(height: 24),
            // Swap Form
            Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: AppTheme.gray50,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppTheme.gray100)),
                child: Column(children: [
                  // From
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SWAP FROM', style: AppTheme.labelXS),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppTheme.blue50,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text('Max: 0 $_fromCurrency',
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.blue600)))
                      ]),
                  const SizedBox(height: 12),
                  Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppTheme.gray100)),
                      child: Row(children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                color: AppTheme.gray50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppTheme.gray100)),
                            child: DropdownButton<String>(
                                value: _fromCurrency,
                                underline: const SizedBox(),
                                isDense: true,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: AppTheme.gray900),
                                items: _currencies
                                    .map((c) => DropdownMenuItem(
                                        value: c['symbol'] as String,
                                        child: Text(c['symbol'] as String)))
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    setState(() {
                                      _fromCurrency = v;
                                      _calcTo();
                                    });
                                  }
                                })),
                        const SizedBox(width: 12),
                        Expanded(
                            child: TextField(
                                controller: _fromCtrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                onChanged: (_) => _calcTo(),
                                decoration: const InputDecoration(
                                    hintText: '0.00',
                                    border: InputBorder.none,
                                    filled: false),
                                style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.gray900))),
                      ])),
                  const SizedBox(height: 16),
                  // Swap icon
                  Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppTheme.gray50, width: 6),
                          boxShadow: AppTheme.shadowMD),
                      child: const Icon(LucideIcons.arrowUpDown,
                          color: AppTheme.blue600, size: 24)),
                  const SizedBox(height: 16),
                  // To
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SWAP TO', style: AppTheme.labelXS),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppTheme.gray100,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                                'Est. Price: 1 $_fromCurrency ≈ ... $_toCurrency',
                                style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.gray400)))
                      ]),
                  const SizedBox(height: 12),
                  Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppTheme.gray100)),
                      child: Row(children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                color: AppTheme.gray50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppTheme.gray100)),
                            child: DropdownButton<String>(
                                value: _toCurrency,
                                underline: const SizedBox(),
                                isDense: true,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: AppTheme.gray900),
                                items: _currencies
                                    .map((c) => DropdownMenuItem(
                                        value: c['symbol'] as String,
                                        child: Text(c['symbol'] as String)))
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    setState(() {
                                      _toCurrency = v;
                                      _calcTo();
                                    });
                                  }
                                })),
                        const SizedBox(width: 12),
                        Expanded(
                            child: TextField(
                                controller: _toCtrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                readOnly: true,
                                decoration: const InputDecoration(
                                    hintText: '0.00',
                                    border: InputBorder.none,
                                    filled: false),
                                style: GoogleFonts.inter(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.gray900))),
                      ])),
                  const SizedBox(height: 24),
                  // Submit
                  SizedBox(
                      width: double.infinity,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: AppTheme.shadowBlue),
                          child: ElevatedButton(
                              onPressed: () {
                                final fc = _currencies.firstWhere(
                                    (c) => c['symbol'] == _fromCurrency,
                                    orElse: () => {});
                                final tc = _currencies.firstWhere(
                                    (c) => c['symbol'] == _toCurrency,
                                    orElse: () => {});
                                widget.onSwap({
                                  'type': 'swap',
                                  'fromAmount': _fromCtrl.text,
                                  'fromCurrency': _fromCurrency,
                                  'fromCurrencyId': fc['id'],
                                  'fromCurrencyIcon': fc['icon_url'],
                                  'toAmount': _toCtrl.text,
                                  'toCurrency': _toCurrency,
                                  'toCurrencyId': tc['id'],
                                  'toCurrencyIcon': tc['icon_url']
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryBlue,
                                  foregroundColor: AppTheme.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 22),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  elevation: 0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Preview Swap',
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18)),
                                    const SizedBox(width: 8),
                                    const Icon(LucideIcons.arrowRight, size: 20)
                                  ])))),
                ])),
          ])),
    ]));
  }
}

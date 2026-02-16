import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BuyCryptocurrency extends StatefulWidget {
  final VoidCallback onBack;
  final Function(Map<String, dynamic>) onExchange;
  final Function(String) onNavigate;
  const BuyCryptocurrency(
      {super.key,
      required this.onBack,
      required this.onExchange,
      required this.onNavigate});
  @override
  State<BuyCryptocurrency> createState() => _BuyCryptocurrencyState();
}

class _BuyCryptocurrencyState extends State<BuyCryptocurrency> {
  final _sendCtrl = TextEditingController();
  final _recvCtrl = TextEditingController();
  List<Map<String, dynamic>> _currencies = [];
  String _fromCurrency = 'NGN';
  String _toCurrency = 'BTC';
  bool _loading = true;
  final _fiats = [
    {'symbol': 'NGN', 'icon': '₦'},
    {'symbol': 'USD', 'icon': '\$'},
    {'symbol': 'EUR', 'icon': '€'},
    {'symbol': 'GBP', 'icon': '£'}
  ];

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    final d = await SupabaseService.getCurrencies();
    // Deduplicate by symbol
    final seen = <String>{};
    final deduped = d.where((c) {
      final sym = c['symbol'] as String?;
      if (sym == null || seen.contains(sym)) return false;
      seen.add(sym);
      return true;
    }).toList();
    setState(() {
      _currencies = deduped;
      // Set to first currency if exists, otherwise keep defaults
      if (deduped.isNotEmpty) {
        _toCurrency = deduped[0]['symbol'] as String? ?? 'BTC';
      }
      _loading = false;
    });
  }

  double _getPrice(String s) {
    final fp = {'USD': 1.0, 'NGN': 0.00065, 'EUR': 1.08, 'GBP': 1.25};
    if (fp.containsKey(s)) return fp[s]!;
    final c = _currencies.firstWhere((c) => c['symbol'] == s, orElse: () => {});
    return double.tryParse(c['price']?.toString() ?? '0') ?? 0;
  }

  void _calc() {
    final v = double.tryParse(_sendCtrl.text);
    if (v == null) {
      _recvCtrl.text = '';
      return;
    }
    final fp = _getPrice(_fromCurrency), tp = _getPrice(_toCurrency);
    if (fp > 0 && tp > 0) _recvCtrl.text = (v * fp / tp).toStringAsFixed(6);
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
                        borderRadius: BorderRadius.circular(16)),
                    child: const Icon(LucideIcons.arrowLeft,
                        color: AppTheme.white))),
            const SizedBox(height: 16),
            Text('Trade Crypto',
                style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.white)),
            Text('Fast, secure cryptocurrency exchange',
                style: GoogleFonts.inter(color: AppTheme.blue200)),
          ])),
      Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppTheme.shadowMD,
                    border: Border.all(color: AppTheme.gray100)),
                child: Row(children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                              color: AppTheme.blue600,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text('Buy/Sell',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.white)))),
                  Expanded(
                      child: GestureDetector(
                          onTap: () => widget.onNavigate('swap'),
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Text('Swap',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.gray500))))),
                ])),
            const SizedBox(height: 24),
            Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: AppTheme.gray50,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppTheme.gray100)),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('YOU PAY', style: AppTheme.labelXS),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppTheme.blue50,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text('Balance: 0 $_fromCurrency',
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
                                borderRadius: BorderRadius.circular(16)),
                            child: DropdownButton<String>(
                              value: _fromCurrency,
                              underline: const SizedBox(),
                              isDense: true,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: AppTheme.gray900),
                              items: _fiats
                                  .map((c) => DropdownMenuItem(
                                      value: c['symbol'] as String,
                                      child: Text(c['symbol'] as String)))
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) {
                                  setState(() {
                                    _fromCurrency = v;
                                    _calc();
                                  });
                                }
                              },
                            )),
                        Expanded(
                            child: TextField(
                                controller: _sendCtrl,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.right,
                                onChanged: (_) {
                                  _calc();
                                },
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
                  Text('YOU RECEIVE', style: AppTheme.labelXS),
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
                                borderRadius: BorderRadius.circular(16)),
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
                                    _calc();
                                  });
                                }
                              },
                            )),
                        Expanded(
                            child: TextField(
                                controller: _recvCtrl,
                                readOnly: true,
                                textAlign: TextAlign.right,
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
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            final tc = _currencies.firstWhere(
                                (c) => c['symbol'] == _toCurrency,
                                orElse: () => {});
                            widget.onExchange({
                              'type': 'buy',
                              'fromAmount': _sendCtrl.text,
                              'fromCurrency': _fromCurrency,
                              'toAmount': _recvCtrl.text,
                              'toCurrency': _toCurrency,
                              'toCurrencyId': tc['id'],
                              'toCurrencyIcon': tc['icon_url']
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              foregroundColor: AppTheme.white,
                              padding: const EdgeInsets.symmetric(vertical: 22),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Preview Order',
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

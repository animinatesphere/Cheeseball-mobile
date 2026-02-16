import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CurrencyDetail extends StatelessWidget {
  final Map<String, dynamic>? currency;
  final VoidCallback onBack;
  final VoidCallback onExchange;
  const CurrencyDetail(
      {super.key,
      this.currency,
      required this.onBack,
      required this.onExchange});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 32),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _btn(LucideIcons.arrowLeft, onBack),
          Row(children: [
            _btn(LucideIcons.bell, () {}),
            const SizedBox(width: 8),
            Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.gray100)),
                child: const Icon(LucideIcons.star,
                    color: AppTheme.primaryBlue, size: 22))
          ]),
        ]),
        const SizedBox(height: 40),
        Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [AppTheme.orange500, Color(0xFFEA580C)]),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: AppTheme.orange500.withValues(alpha: 0.3),
                      blurRadius: 20)
                ]),
            child: currency?['icon_url'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(currency!['icon_url'],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                            child: Text(currency?['icon'] ?? '₿',
                                style: GoogleFonts.inter(
                                    color: AppTheme.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900)))))
                : Center(
                    child: Text(currency?['icon'] ?? '₿',
                        style: GoogleFonts.inter(color: AppTheme.white, fontSize: 36, fontWeight: FontWeight.w900)))),
        const SizedBox(height: 24),
        Row(children: [
          Text((currency?['fullName'] ?? 'BITCOIN').toString().toUpperCase(),
              style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.gray900)),
          const SizedBox(width: 12),
          Text(currency?['name'] ?? 'BTC',
              style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.gray300))
        ]),
        const SizedBox(height: 8),
        Text(currency?['price'] ?? '\$86,244.91',
            style: GoogleFonts.inter(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: AppTheme.gray900,
                letterSpacing: -2)),
        Text(currency?['change'] ?? '-2.95%',
            style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: currency?['positive'] != false
                    ? AppTheme.green500
                    : AppTheme.red500)),
        const SizedBox(height: 32),
        SizedBox(
            width: double.infinity,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: AppTheme.shadowBlue),
                child: ElevatedButton.icon(
                    onPressed: onExchange,
                    icon: const Icon(LucideIcons.arrowUpDown, size: 22),
                    label: Text('Instant Swap',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w900, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        foregroundColor: AppTheme.white,
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        elevation: 0)))),
        const SizedBox(height: 32),
        Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
                color: AppTheme.gray50,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppTheme.gray100)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('MARKET PERFORMANCE',
                  style: AppTheme.labelXS.copyWith(fontSize: 11)),
              const SizedBox(height: 24),
              ...[
                {'l': 'Market Cap', 'v': '\$1.7T', 'c': AppTheme.blue600},
                {'l': '24h Volume', 'v': '\$35.2B', 'c': AppTheme.green600},
                {
                  'l': 'Circulating Supply',
                  'v': '19.6M BTC',
                  'c': AppTheme.orange600
                },
                {
                  'l': 'All Time High',
                  'v': '\$93,450.12',
                  'c': AppTheme.gray900
                }
              ].map((s) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: AppTheme.gray200))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(s['l'] as String,
                            style: GoogleFonts.inter(
                                color: AppTheme.gray500,
                                fontWeight: FontWeight.w700)),
                        Text(s['v'] as String,
                            style: GoogleFonts.inter(
                                color: s['c'] as Color,
                                fontWeight: FontWeight.w900,
                                fontSize: 16))
                      ]))),
            ])),
      ]),
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap) => GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.gray100),
              boxShadow: AppTheme.shadowSM),
          child: Icon(icon, color: AppTheme.gray900, size: 22)));
}

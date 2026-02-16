import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AlertRatesPage extends StatelessWidget {
  final VoidCallback onBack;
  const AlertRatesPage({super.key, required this.onBack});

  @override Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      Container(decoration: const BoxDecoration(gradient: AppTheme.blueGradient), padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(onTap: onBack, child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(16)), child: const Icon(LucideIcons.arrowLeft, color: AppTheme.white))),
          const SizedBox(height: 16),
          Text('Price Alerts', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w900, color: AppTheme.white)),
          Text('Get notified when prices change', style: GoogleFonts.inter(color: AppTheme.blue200)),
        ])),
      Padding(padding: const EdgeInsets.all(24), child: Column(children: [
        Container(padding: const EdgeInsets.all(48), decoration: BoxDecoration(color: AppTheme.gray50, borderRadius: BorderRadius.circular(40), border: Border.all(color: AppTheme.gray100)),
          child: Column(children: [
            Container(width: 80, height: 80, decoration: BoxDecoration(color: AppTheme.white, shape: BoxShape.circle, boxShadow: AppTheme.shadowSM), child: const Icon(LucideIcons.bell, color: AppTheme.gray300, size: 36)),
            const SizedBox(height: 24),
            Text('No alerts set', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w900, color: AppTheme.gray900)),
            const SizedBox(height: 8),
            Text('Set price alerts to get notified when your favorite assets reach a target price.', textAlign: TextAlign.center, style: GoogleFonts.inter(color: AppTheme.gray400, fontWeight: FontWeight.w500)),
          ])),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(LucideIcons.plus, size: 20), label: Text('Create Alert', style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 16)),
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryBlue, foregroundColor: AppTheme.white, padding: const EdgeInsets.symmetric(vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))))),
      ])),
    ]));
  }
}

import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:ui';

class BottomNav extends StatelessWidget {
  final String currentPage;
  final Function(String) onNavigate;
  const BottomNav(
      {super.key, required this.currentPage, required this.onNavigate});

  bool _isActive(String id) {
    if (id == 'support') {
      return currentPage == 'support' || currentPage == 'address-book';
    }
    if (id == 'buy') {
      return [
        'buy',
        'buy-address',
        'complete-order',
        'complete-order-email',
        'otp',
        'personal-data',
        'bank-transfer'
      ].contains(currentPage);
    }
    if (id == 'rates') {
      return ['rates', 'detail', 'swap', 'confirm', 'awaiting', 'alert-rates']
          .contains(currentPage);
    }
    return currentPage == id;
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {'id': 'rates', 'icon': LucideIcons.trendingUp, 'label': 'Market'},
      {'id': 'buy', 'icon': LucideIcons.shoppingCart, 'label': 'Trade'},
      {'id': 'history', 'icon': LucideIcons.clock, 'label': 'History'},
      {'id': 'support', 'icon': LucideIcons.user, 'label': 'Support'},
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white24),
              boxShadow: [
                BoxShadow(
                    color: AppTheme.blue800.withValues(alpha: 0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 8))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.map((item) {
                final active = _isActive(item['id'] as String);
                return GestureDetector(
                  onTap: () => onNavigate(item['id'] as String),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color:
                                active ? AppTheme.blue50 : Colors.transparent,
                            borderRadius: BorderRadius.circular(12)),
                        child: Icon(item['icon'] as IconData,
                            size: 24,
                            color:
                                active ? AppTheme.blue600 : AppTheme.gray400),
                      ),
                      const SizedBox(height: 4),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: active ? 1.0 : 0.0,
                        child: Text((item['label'] as String).toUpperCase(),
                            style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                                color: active
                                    ? AppTheme.blue600
                                    : AppTheme.gray400)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

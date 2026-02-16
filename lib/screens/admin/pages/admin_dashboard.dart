import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: IndexedStack(index: _currentIndex, children: [
        _buildHome(),
        _buildOrders(),
        _buildCurrencies(),
        _buildAccount(),
      ]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: AppTheme.white,
            border: Border(top: BorderSide(color: AppTheme.gray100))),
        child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navItem(0, LucideIcons.home, 'Home'),
                      _navItem(1, LucideIcons.shoppingBag, 'Orders'),
                      _navItem(2, LucideIcons.coins, 'Currencies'),
                      _navItem(3, LucideIcons.user, 'Account'),
                    ]))),
      ),
    );
  }

  Widget _navItem(int idx, IconData icon, String label) => GestureDetector(
      onTap: () => setState(() => _currentIndex = idx),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon,
            color: _currentIndex == idx ? AppTheme.blue600 : AppTheme.gray400,
            size: 24),
        const SizedBox(height: 4),
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _currentIndex == idx
                    ? AppTheme.blue600
                    : AppTheme.gray400)),
      ]));

  Widget _buildHome() {
    return FutureBuilder<Map<String, dynamic>>(
      future: SupabaseService.getAdminStats(),
      builder: (context, snap) {
        final stats =
            snap.data ?? {'orderCount': 0, 'currencyCount': 0, 'volume': '0'};
        return SingleChildScrollView(
            child: Column(children: [
          Container(
              decoration: const BoxDecoration(gradient: AppTheme.blueGradient),
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Dashboard',
                              style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.white)),
                          Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Icon(LucideIcons.bell,
                                  color: AppTheme.white, size: 20)),
                        ]),
                    Text('Admin Overview',
                        style: GoogleFonts.inter(color: AppTheme.blue200)),
                  ])),
          Padding(
              padding: const EdgeInsets.all(24),
              child: Column(children: [
                Row(children: [
                  Expanded(
                      child: _statCard(
                          'Orders',
                          '${stats['orderCount']}',
                          LucideIcons.shoppingBag,
                          AppTheme.blue600,
                          AppTheme.blue50)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _statCard(
                          'Currencies',
                          '${stats['currencyCount']}',
                          LucideIcons.coins,
                          AppTheme.green600,
                          AppTheme.green50)),
                ]),
                const SizedBox(height: 12),
                _statCard(
                    'Volume',
                    stats['volume'].toString(),
                    LucideIcons.trendingUp,
                    AppTheme.orange600,
                    AppTheme.orange50),
              ])),
        ]));
      },
    );
  }

  Widget _statCard(
          String label, String value, IconData icon, Color color, Color bg) =>
      Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppTheme.gray100),
              boxShadow: AppTheme.shadowSM),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: bg, borderRadius: BorderRadius.circular(16)),
                child: Icon(icon, color: color, size: 22)),
            const SizedBox(height: 16),
            Text(value,
                style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.gray900)),
            Text(label.toUpperCase(), style: AppTheme.labelXS),
          ]));

  Widget _buildOrders() => const Center(child: Text('Orders - Coming Soon'));
  Widget _buildCurrencies() =>
      const Center(child: Text('Currencies - Coming Soon'));
  Widget _buildAccount() => Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Admin Account', style: AppTheme.headingMD),
        const SizedBox(height: 24),
        ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            child: const Text('Sign Out')),
      ]));
}

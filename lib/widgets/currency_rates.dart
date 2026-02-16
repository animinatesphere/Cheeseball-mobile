import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CurrencyRates extends StatefulWidget {
  final Function(Map<String, dynamic>) onSelectCurrency;
  final Function(String) onNavigate;
  const CurrencyRates(
      {super.key, required this.onSelectCurrency, required this.onNavigate});
  @override
  State<CurrencyRates> createState() => _CurrencyRatesState();
}

class _CurrencyRatesState extends State<CurrencyRates> {
  String _searchTerm = '';
  String _activeTab = 'all';
  List<Map<String, dynamic>> _currencies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
  }

  Future<void> _fetchCurrencies() async {
    setState(() => _loading = true);
    try {
      final data = await SupabaseService.getCurrencies();
      setState(() => _currencies = data);
    } catch (e) {
      debugPrint('Error: $e');
    }
    setState(() => _loading = false);
  }

  List<Map<String, dynamic>> get _filtered => _currencies.where((c) {
        final name = (c['name'] ?? '').toString().toLowerCase();
        final symbol = (c['symbol'] ?? '').toString().toLowerCase();
        return name.contains(_searchTerm.toLowerCase()) ||
            symbol.contains(_searchTerm.toLowerCase());
      }).toList();

  Color _parseColor(String? colorClass) {
    if (colorClass == null) {
      return AppTheme.blue600;
    }
    if (colorClass.contains('orange')) {
      return AppTheme.orange500;
    }
    if (colorClass.contains('green')) {
      return AppTheme.green500;
    }
    if (colorClass.contains('red')) {
      return AppTheme.red500;
    }
    if (colorClass.contains('blue')) {
      return AppTheme.blue600;
    }
    return AppTheme.gray500;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
          child: CircularProgressIndicator(color: AppTheme.blue600));
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(gradient: AppTheme.blueGradient),
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Market Rates',
                              style: GoogleFonts.inter(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.white,
                                  letterSpacing: -0.5)),
                          Text('Real-time cryptocurrency insights',
                              style: GoogleFonts.inter(
                                  color: AppTheme.blue200,
                                  fontWeight: FontWeight.w500)),
                        ]),
                    GestureDetector(
                      onTap: () => widget.onNavigate('alert-rates'),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white10)),
                        child: const Icon(LucideIcons.bell,
                            color: AppTheme.white, size: 22),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextField(
                  onChanged: (v) => setState(() => _searchTerm = v),
                  style: GoogleFonts.inter(color: AppTheme.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Search for currency...',
                    hintStyle: GoogleFonts.inter(color: AppTheme.blue200),
                    prefixIcon:
                        const Icon(LucideIcons.search, color: AppTheme.blue200),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: Colors.white24)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: Colors.white24)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(
                            color: AppTheme.blue600.withValues(alpha: 0.5),
                            width: 2)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                  ),
                ),
              ],
            ),
          ),
          // Tab Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppTheme.shadowMD,
                    border: Border.all(color: AppTheme.gray100)),
                child: Row(
                  children: ['All Market', 'Favorites'].map((tab) {
                    final isActive =
                        (tab == 'All Market' && _activeTab == 'all') ||
                            (tab == 'Favorites' && _activeTab == 'favorites');
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _activeTab =
                            tab == 'All Market' ? 'all' : 'favorites'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                              color: isActive
                                  ? AppTheme.blue600
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: isActive
                                  ? [
                                      const BoxShadow(
                                          color: AppTheme.blue100,
                                          blurRadius: 8)
                                    ]
                                  : null),
                          child: Text(tab,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  color: isActive
                                      ? AppTheme.white
                                      : AppTheme.gray500)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          // Currency Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _filtered.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(48),
                    child: Text('No active currencies found.',
                        style: GoogleFonts.inter(
                            color: AppTheme.gray400,
                            fontWeight: FontWeight.w700)))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.78,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final c = _filtered[index];
                      final isPositive = c['is_positive'] == true;
                      final color = _parseColor(c['color_class']);
                      return GestureDetector(
                        onTap: () => widget.onSelectCurrency({
                          'id': c['id'],
                          'name': c['symbol'],
                          'fullName': c['name'],
                          'price': '\$${_formatNum(c['price'])}',
                          'change': c['change_24h'] ?? '0%',
                          'positive': isPositive,
                          'icon': (c['symbol'] ?? '\$')[0],
                          'colorClass': c['color_class'],
                          'icon_url': c['icon_url'],
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(color: AppTheme.gray100),
                              boxShadow: AppTheme.shadowSM),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: color,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          boxShadow: [
                                            BoxShadow(
                                                color: color.withValues(
                                                    alpha: 0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4))
                                          ]),
                                      child: c['icon_url'] != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: Image.network(c['icon_url'],
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) => Center(
                                                      child: Text(
                                                          (c['symbol'] ??
                                                              '\$')[0],
                                                          style: GoogleFonts.inter(
                                                              color: AppTheme
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight.w900,
                                                              fontSize: 20)))))
                                          : Center(child: Text((c['symbol'] ?? '\$')[0], style: GoogleFonts.inter(color: AppTheme.white, fontWeight: FontWeight.w900, fontSize: 20))),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: isPositive
                                              ? AppTheme.green50
                                              : AppTheme.red50,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(c['change_24h'] ?? '0%',
                                          style: GoogleFonts.inter(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: isPositive
                                                  ? AppTheme.green600
                                                  : AppTheme.red600)),
                                    ),
                                  ]),
                              const Spacer(),
                              Text(c['symbol'] ?? '',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.gray900)),
                              Text(c['name'] ?? '',
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.gray400)),
                              const Spacer(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('PRICE',
                                              style: AppTheme.labelXS
                                                  .copyWith(fontSize: 9)),
                                          Text('\$${_formatNum(c['price'])}',
                                              style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900,
                                                  color: AppTheme.gray900)),
                                        ]),
                                    Icon(
                                        isPositive
                                            ? LucideIcons.trendingUp
                                            : LucideIcons.trendingDown,
                                        size: 28,
                                        color: isPositive
                                            ? AppTheme.green500
                                            : AppTheme.red500),
                                  ]),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _formatNum(dynamic val) {
    if (val == null) {
      return '0';
    }
    final n = double.tryParse(val.toString()) ?? 0;
    if (n >= 1000) {
      return n.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
    }
    if (n >= 1) {
      return n.toStringAsFixed(2);
    }
    return n.toStringAsFixed(4);
  }
}

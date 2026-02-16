import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  final Function(String) onNavigate;
  const HistoryPage({super.key, required this.onNavigate});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _transactions = [];
  bool _loading = true;
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() => _loading = true);
    try {
      final user = SupabaseService.currentUser;
      if (user != null) {
        _transactions = await SupabaseService.getUserTransactions(user.id);
      }
    } catch (e) {
      // Error handled silently
    }
    setState(() => _loading = false);
  }

  List<Map<String, dynamic>> get _filtered => _filter == 'all'
      ? _transactions
      : _transactions
          .where((t) => (t['type'] ?? '').toString().toLowerCase() == _filter)
          .toList();

  Color _statusColor(String? s) {
    switch (s?.toLowerCase()) {
      case 'approved':
        return AppTheme.green600;
      case 'declined':
        return AppTheme.red600;
      default:
        return AppTheme.orange600;
    }
  }

  Color _statusBg(String? s) {
    switch (s?.toLowerCase()) {
      case 'approved':
        return AppTheme.green50;
      case 'declined':
        return AppTheme.red50;
      default:
        return AppTheme.orange50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(gradient: AppTheme.blueGradient),
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction History',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.white,
                ),
              ),
              Text(
                'Track your exchange activity',
                style: GoogleFonts.inter(color: AppTheme.blue200),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Transform.translate(
            offset: const Offset(0, -16),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppTheme.shadowMD,
                border: Border.all(color: AppTheme.gray100),
              ),
              child: Row(
                children: ['all', 'buy', 'swap']
                    .map(
                      (t) => Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _filter = t),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _filter == t
                                  ? AppTheme.blue600
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              t == 'all'
                                  ? 'All'
                                  : t[0].toUpperCase() + t.substring(1),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: _filter == t
                                    ? AppTheme.white
                                    : AppTheme.gray500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        if (_loading)
          const Padding(
            padding: EdgeInsets.all(48),
            child: CircularProgressIndicator(color: AppTheme.blue600),
          )
        else if (_filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: AppTheme.gray50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.clock,
                    color: AppTheme.gray300,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'No transactions yet',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.gray900,
                  ),
                ),
                Text(
                  'Your exchange history will appear here',
                  style: AppTheme.bodySM,
                ),
              ],
            ),
          )
        else
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: _filtered.map((t) {
                  final fromSym = t['from_currency']?['symbol'] ?? '?';
                  final toSym = t['to_currency']?['symbol'] ?? '?';
                  final status = (t['status'] ?? 'waiting').toString();
                  final date = DateTime.tryParse(t['created_at'] ?? '');
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppTheme.gray100),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: t['type'] == 'swap'
                                ? AppTheme.blue50
                                : AppTheme.green50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            t['type'] == 'swap'
                                ? LucideIcons.arrowUpDown
                                : LucideIcons.shoppingCart,
                            color: t['type'] == 'swap'
                                ? AppTheme.blue600
                                : AppTheme.green600,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$fromSym → $toSym',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: AppTheme.gray900,
                                ),
                              ),
                              if (date != null)
                                Text(
                                  DateFormat('MMM d, yyyy • h:mm a')
                                      .format(date),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppTheme.gray400,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${t['to_amount'] ?? '0'} $toSym',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.gray900,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusBg(status),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status[0].toUpperCase() + status.substring(1),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: _statusColor(status),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}

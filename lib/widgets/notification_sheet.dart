import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class NotificationSheet extends StatefulWidget {
  const NotificationSheet({super.key});

  @override
  State<NotificationSheet> createState() => _NotificationSheetState();
}

class _NotificationSheetState extends State<NotificationSheet> {
  List<Map<String, dynamic>> _transactions = [];
  bool _loading = true;

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
        final all = await SupabaseService.getUserTransactions(user.id);
        _transactions = all.take(10).toList();
      }
    } catch (_) {}
    setState(() => _loading = false);
  }

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

  IconData _typeIcon(String? type) {
    return type == 'swap' ? LucideIcons.arrowUpDown : LucideIcons.shoppingCart;
  }

  Color _typeColor(String? type) {
    return type == 'swap' ? AppTheme.blue600 : AppTheme.green600;
  }

  Color _typeBg(String? type) {
    return type == 'swap' ? AppTheme.blue50 : AppTheme.green50;
  }

  String _label(Map<String, dynamic> t) {
    final from = t['from_currency']?['symbol'] ?? '?';
    final to = t['to_currency']?['symbol'] ?? '?';
    final type = (t['type'] ?? '').toString();
    if (type == 'swap') return 'Swap $from → $to';
    return 'Buy $to';
  }

  String _amount(Map<String, dynamic> t) {
    final to = t['to_currency']?['symbol'] ?? '';
    return '+${t['to_amount'] ?? '0'} $to';
  }

  String _timeAgo(String? raw) {
    if (raw == null) return '';
    final date = DateTime.tryParse(raw);
    if (date == null) return '';
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.gray200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Notifications',
                        style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.gray900)),
                    Text('Your recent transactions',
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.gray400)),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.gray100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(LucideIcons.x,
                        size: 18, color: AppTheme.gray600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppTheme.gray100, height: 1),
          // Body
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: _loading
                ? const Padding(
                    padding: EdgeInsets.all(48),
                    child: Center(
                        child: CircularProgressIndicator(
                            color: AppTheme.blue600)),
                  )
                : _transactions.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(48),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: const BoxDecoration(
                                color: AppTheme.gray50,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(LucideIcons.bellOff,
                                  size: 32, color: AppTheme.gray300),
                            ),
                            const SizedBox(height: 16),
                            Text('No notifications yet',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.gray900)),
                            const SizedBox(height: 4),
                            Text('Your transaction updates will appear here',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.gray400)),
                          ],
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                        itemCount: _transactions.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, i) {
                          final t = _transactions[i];
                          final status =
                              (t['status'] ?? 'waiting').toString();
                          final type =
                              (t['type'] ?? '').toString();
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: AppTheme.gray100),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: _typeBg(type),
                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                  child: Icon(_typeIcon(type),
                                      size: 20,
                                      color: _typeColor(type)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_label(t),
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                              fontWeight:
                                                  FontWeight.w800,
                                              fontSize: 14,
                                              color:
                                                  AppTheme.gray900)),
                                      const SizedBox(height: 3),
                                      Row(children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 2),
                                          decoration: BoxDecoration(
                                            color: _statusBg(status),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                          ),
                                          child: Text(
                                            status[0].toUpperCase() +
                                                status.substring(1),
                                            style: GoogleFonts.inter(
                                                fontSize: 10,
                                                fontWeight:
                                                    FontWeight.w900,
                                                color: _statusColor(
                                                    status)),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                            _timeAgo(
                                                t['created_at']
                                                    ?.toString()),
                                            style: GoogleFonts.inter(
                                                fontSize: 11,
                                                fontWeight:
                                                    FontWeight.w500,
                                                color:
                                                    AppTheme.gray400)),
                                      ]),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(_amount(t),
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 13,
                                        color: AppTheme.green600)),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

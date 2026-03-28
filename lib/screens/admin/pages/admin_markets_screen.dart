import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminMarketsScreen extends StatefulWidget {
  const AdminMarketsScreen({super.key});

  @override
  State<AdminMarketsScreen> createState() => _AdminMarketsScreenState();
}

class _AdminMarketsScreenState extends State<AdminMarketsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSyncing = false;

  void _syncPrices() async {
    setState(() => _isSyncing = true);
    // Mock sync delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSyncing = false);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prices synced with CoinGecko API successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text('MARKET MANAGEMENT', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText, letterSpacing: 1.5)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: _isSyncing ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.accentGold)) : const Icon(LucideIcons.refreshCw),
            onPressed: _isSyncing ? null : _syncPrices,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterTabs(),
          Expanded(child: _buildAssetList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: AppTheme.darkText),
        decoration: const InputDecoration(
          hintText: 'Search coins...',
          prefixIcon: Icon(LucideIcons.search, color: AppTheme.darkTextSecondary),
          fillColor: AppTheme.darkCard,
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildFilterChip('Enabled', true),
          const SizedBox(width: 12),
          _buildFilterChip('Archived', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? AppTheme.accentGold : AppTheme.darkSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: active ? AppTheme.accentGold : AppTheme.darkHighlight),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: active ? AppTheme.darkBg : AppTheme.darkTextSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildAssetList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) => _buildAssetTile(index),
    );
  }

  Widget _buildAssetTile(int index) {
    bool isEnabled = index < 8;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        border: Border.all(color: AppTheme.darkHighlight),
      ),
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: AppTheme.darkSurface, child: Icon(LucideIcons.coins, color: AppTheme.accentGold)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bitcoin', style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
                Text('BTC/NGN', style: AppTheme.bodyXS.copyWith(color: AppTheme.darkTextSecondary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('₦ 65,432,000', style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
              Switch(
                value: isEnabled,
                onChanged: (val) {},
                activeThumbColor: AppTheme.accentGold,
                activeTrackColor: AppTheme.accentGold.withValues(alpha: 0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  String fromAsset = 'BTC';
  String toAsset = 'USDT';
  double fromAmount = 0.0;
  double exchangeRate = 65432.10; // Mock rate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAssetInput(
              label: 'From',
              asset: fromAsset,
              amount: fromAmount.toString(),
              isInput: true,
              onAssetTap: () => _showAssetPicker(true),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.darkHighlight, width: 2),
                ),
                child: const Icon(LucideIcons.arrowUpDown, color: AppTheme.accentGold, size: 24),
              ),
            ),
            _buildAssetInput(
              label: 'To',
              asset: toAsset,
              amount: (fromAmount * exchangeRate).toStringAsFixed(2),
              isInput: false,
              onAssetTap: () => _showAssetPicker(false),
            ),
            const SizedBox(height: 32),
            _buildRateInfo(),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: fromAmount > 0 ? () {} : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: AppTheme.accentGold,
                  disabledBackgroundColor: AppTheme.darkHighlight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                  ),
                ),
                child: Text(
                  'Convert Now',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: fromAmount > 0 ? AppTheme.darkBg : AppTheme.darkTextSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetInput({
    required String label,
    required String asset,
    required String amount,
    required bool isInput,
    required VoidCallback onAssetTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusLG),
        border: Border.all(color: AppTheme.darkHighlight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppTheme.darkTextSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: isInput
                    ? TextField(
                        style: AppTheme.headingMD.copyWith(color: AppTheme.darkText),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0.00',
                          hintStyle: AppTheme.headingMD.copyWith(color: AppTheme.darkHighlight),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          fillColor: Colors.transparent,
                        ),
                        onChanged: (val) {
                          setState(() {
                            fromAmount = double.tryParse(val) ?? 0.0;
                          });
                        },
                      )
                    : Text(
                        amount == '0.00' ? '0.00' : amount,
                        style: AppTheme.headingMD.copyWith(
                          color: amount == '0.00' ? AppTheme.darkHighlight : AppTheme.darkText,
                        ),
                      ),
              ),
              GestureDetector(
                onTap: onAssetTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.darkSurface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSM),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppTheme.accentGold,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.coins, size: 14, color: AppTheme.darkBg),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        asset,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkText,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(LucideIcons.chevronDown, size: 16, color: AppTheme.darkTextSecondary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRateInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.darkSurface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ref. Price',
            style: GoogleFonts.inter(color: AppTheme.darkTextSecondary),
          ),
          Text(
            '1 $fromAsset ≈ $exchangeRate $toAsset',
            style: GoogleFonts.inter(
              color: AppTheme.darkText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showAssetPicker(bool isFrom) {
    // Mock picker
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Asset', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
            const SizedBox(height: 20),
            _buildAssetTile('BTC', 'Bitcoin'),
            _buildAssetTile('ETH', 'Ethereum'),
            _buildAssetTile('USDT', 'Tether'),
            _buildAssetTile('BNB', 'BNB'),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetTile(String code, String name) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: AppTheme.darkSurface,
          shape: BoxShape.circle,
        ),
        child: const Icon(LucideIcons.coins, color: AppTheme.accentGold),
      ),
      title: Text(code, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
      subtitle: Text(name, style: const TextStyle(color: AppTheme.darkTextSecondary)),
      onTap: () {
        setState(() {
          // Logic for selecting asset
        });
        Navigator.pop(context);
      },
    );
  }
}

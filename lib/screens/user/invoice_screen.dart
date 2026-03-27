import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String selectedAsset = 'BTC';
  double amount = 0.0;
  String? generatedAddress = 'bc1qxy2kgdyqrrejb5hx';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text('Crypto Invoice', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildAssetSelector(),
            const SizedBox(height: 32),
            _buildAmountInput(),
            const SizedBox(height: 48),
            if (generatedAddress != null) _buildQRCodeArea(),
            const SizedBox(height: 48),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        border: Border.all(color: AppTheme.darkHighlight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.wallet, color: AppTheme.accentGold),
              const SizedBox(width: 12),
              Text('Receive in', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary)),
            ],
          ),
          DropdownButton<String>(
            value: selectedAsset,
            dropdownColor: AppTheme.darkBg,
            underline: Container(),
            onChanged: (val) => setState(() => selectedAsset = val!),
            items: ['BTC', 'ETH', 'USDT', 'LTC'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Amount to Request (Optional)', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          keyboardType: TextInputType.number,
          style: AppTheme.headingMD.copyWith(color: AppTheme.darkText),
          decoration: const InputDecoration(
            hintText: '0.00',
            prefixText: '\$ ',
            prefixStyle: TextStyle(color: AppTheme.darkTextSecondary),
          ),
        ),
      ],
    );
  }

  Widget _buildQRCodeArea() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusLG),
            border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.2), width: 4),
          ),
          child: QrImageView(
            data: generatedAddress!,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            border: Border.all(color: AppTheme.darkHighlight),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(generatedAddress!, style: GoogleFonts.inter(color: AppTheme.darkText, fontSize: 13), overflow: TextOverflow.ellipsis),
              ),
              IconButton(onPressed: () {}, icon: const Icon(LucideIcons.copy, color: AppTheme.accentGold, size: 20)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: const Text('Share Payment Link'),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: Text('Add to Wallet', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary)),
        ),
      ],
    );
  }
}

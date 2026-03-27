import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<PayoutScreen> createState() => _PayoutScreenState();
}

class _PayoutScreenState extends State<PayoutScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? selectedBank = 'Opay Digital Bank';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text('Withdraw / Settlement', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 32),
            _buildBankSelector(),
            const SizedBox(height: 24),
            _buildAmountInput(),
            const SizedBox(height: 48),
            _buildActionButtons(),
            const SizedBox(height: 24),
            Text(
              'Transactions are settled instantly via Paystack / Flutterwave Gateway.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.darkHighlight, AppTheme.darkCard],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLG),
        border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Available Balance', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontSize: 13)),
              const SizedBox(height: 8),
              Text('₦ 456,234.00', style: AppTheme.headingMD.copyWith(color: AppTheme.darkText)),
            ],
          ),
          const Icon(LucideIcons.wallet, color: AppTheme.accentGold, size: 32),
        ],
      ),
    );
  }

  Widget _buildBankSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        border: Border.all(color: AppTheme.darkHighlight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Withdraw to', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedBank!, style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
              const Icon(LucideIcons.chevronDown, color: AppTheme.darkTextSecondary),
            ],
          ),
          const SizedBox(height: 16),
          Text('John Doe | 0123456789', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Withdrawal Amount', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          style: AppTheme.headingMD.copyWith(color: AppTheme.darkText),
          decoration: InputDecoration(
            hintText: 'Minimum ₦1,000',
            hintStyle: TextStyle(color: AppTheme.darkHighlight),
            suffixText: 'NAIRA',
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Confirm Settlement'),
      ),
    );
  }
}

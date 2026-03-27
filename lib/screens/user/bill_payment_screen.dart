import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  String selectedCategory = 'Airtime';
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Airtime', 'icon': LucideIcons.phoneCall, 'color': Colors.blue},
    {'name': 'Data', 'icon': LucideIcons.wifi, 'color': Colors.green},
    {'name': 'Electricity', 'icon': LucideIcons.zap, 'color': Colors.amber},
    {'name': 'Cable TV', 'icon': LucideIcons.tv, 'color': Colors.pink},
    {'name': 'Internet', 'icon': LucideIcons.globe, 'color': Colors.indigo},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text('Bill Payments', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What would you like to pay?',
              style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkText),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  bool isSelected = selectedCategory == cat['name'];
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat['name']),
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.accentGold : AppTheme.darkCard,
                        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                        border: Border.all(color: isSelected ? AppTheme.accentGold : AppTheme.darkHighlight),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'], color: isSelected ? AppTheme.darkBg : cat['color'], size: 28),
                          const SizedBox(height: 8),
                          Text(
                            cat['name'],
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppTheme.darkBg : AppTheme.darkTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            _buildPaymentForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputLabel('Select Provider'),
        const SizedBox(height: 12),
        _buildDropdownSelector('MTN Nigeria'),
        const SizedBox(height: 24),
        _buildInputLabel('Phone Number / Account ID'),
        const SizedBox(height: 12),
        TextField(
          style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText),
          decoration: const InputDecoration(
            hintText: 'Enter account detail',
          ),
        ),
        const SizedBox(height: 24),
        _buildInputLabel('Amount'),
        const SizedBox(height: 12),
        TextField(
          keyboardType: TextInputType.number,
          style: AppTheme.headingMD.copyWith(color: AppTheme.darkText),
          decoration: const InputDecoration(
            hintText: '₦ 0.00',
            prefixIcon: Icon(LucideIcons.banknote, color: AppTheme.darkTextSecondary),
          ),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Pay for $selectedCategory'),
          ),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: AppTheme.darkTextSecondary,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
    );
  }

  Widget _buildDropdownSelector(String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkSurface,
        borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        border: Border.all(color: AppTheme.darkHighlight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText)),
          const Icon(LucideIcons.chevronDown, color: AppTheme.darkTextSecondary, size: 20),
        ],
      ),
    );
  }
}

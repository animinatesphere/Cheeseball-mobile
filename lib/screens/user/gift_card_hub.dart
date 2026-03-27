import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class GiftCardHub extends StatefulWidget {
  const GiftCardHub({super.key});

  @override
  State<GiftCardHub> createState() => _GiftCardHubState();
}

class _GiftCardHubState extends State<GiftCardHub> {
  String? selectedBrand;
  String? selectedCountry = 'USA';
  double rate = 850.0; // Mock rate (Naira per USD)
  final TextEditingController _amountController = TextEditingController();
  double calculatedCredit = 0.0;

  final List<Map<String, dynamic>> _brands = [
    {'name': 'Amazon', 'icon': LucideIcons.shoppingBag, 'color': Colors.orange},
    {'name': 'iTunes', 'icon': LucideIcons.music, 'color': Colors.pink},
    {'name': 'Steam', 'icon': LucideIcons.gamepad2, 'color': Colors.blue},
    {'name': 'Google Play', 'icon': LucideIcons.play, 'color': Colors.green},
    {'name': 'Visa', 'icon': LucideIcons.creditCard, 'color': Colors.purple},
    {'name': 'Xbox', 'icon': LucideIcons.gamepad, 'color': Colors.greenAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text('Gift Card Hub', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: selectedBrand == null ? _buildBrandSelection() : _buildHubDetail(),
    );
  }

  Widget _buildBrandSelection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Card Brand',
            style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.darkText),
          ),
          const SizedBox(height: 8),
          Text(
            'Over 20+ cards currently supported',
            style: GoogleFonts.inter(color: AppTheme.darkTextSecondary),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemCount: _brands.length,
              itemBuilder: (context, index) {
                final brand = _brands[index];
                return GestureDetector(
                  onTap: () => setState(() => selectedBrand = brand['name']),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.darkCard,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                      border: Border.all(color: AppTheme.darkHighlight),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(brand['icon'], color: brand['color'], size: 32),
                        const SizedBox(height: 12),
                        Text(
                          brand['name'],
                          style: GoogleFonts.inter(
                            color: AppTheme.darkText,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHubDetail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => selectedBrand = null),
                child: const Icon(LucideIcons.x, color: AppTheme.darkTextSecondary, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                '$selectedBrand Details',
                style: AppTheme.headingSM.copyWith(color: AppTheme.darkText),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildDetailInput(
            label: 'Country/Region',
            widget: _buildDropdownSelector('USA'),
          ),
          const SizedBox(height: 24),
          _buildDetailInput(
            label: 'Card Amount (\$)',
            widget: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: AppTheme.headingMD.copyWith(color: AppTheme.darkText),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: AppTheme.headingMD.copyWith(color: AppTheme.darkHighlight),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.transparent,
              ),
              onChanged: (val) {
                setState(() {
                  double amt = double.tryParse(val) ?? 0.0;
                  calculatedCredit = amt * rate;
                });
              },
            ),
          ),
          const SizedBox(height: 32),
          _buildRateInfoCard(),
          const SizedBox(height: 32),
          _buildImageUploadArea(),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: calculatedCredit > 0 ? () {} : null,
              child: const Text('Submit Transaction'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailInput({required String label, required Widget widget}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusLG),
        border: Border.all(color: AppTheme.darkHighlight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          widget,
        ],
      ),
    );
  }

  Widget _buildDropdownSelector(String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value, style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
        const Icon(LucideIcons.chevronDown, color: AppTheme.darkTextSecondary),
      ],
    );
  }

  Widget _buildRateInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.accentGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Current Rate', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary)),
              Text('\$1 = ₦$rate', style: GoogleFonts.inter(color: AppTheme.accentGold, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppTheme.darkHighlight),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You will receive', style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
              Text('₦${calculatedCredit.toStringAsFixed(2)}', style: AppTheme.headingSM.copyWith(color: AppTheme.accentGold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card Proof / Image', style: GoogleFonts.inter(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            border: Border.all(color: AppTheme.darkHighlight, style: BorderStyle.none), // Mocking dash border
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.image, color: AppTheme.darkTextSecondary, size: 32),
              const SizedBox(height: 12),
              Text('Tap to upload card front/back', style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}

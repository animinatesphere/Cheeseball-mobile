import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Text('ORDER MANAGEMENT', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText, letterSpacing: 1.5)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accentGold,
          labelColor: AppTheme.accentGold,
          unselectedLabelColor: AppTheme.darkTextSecondary,
          tabs: const [
            Tab(text: 'CRYPTO'),
            Tab(text: 'GIFT CARDS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCryptoOrders(),
          _buildGiftCardOrders(),
        ],
      ),
    );
  }

  Widget _buildCryptoOrders() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => _buildOrderCard(
        type: 'Crypto Swap',
        amount: '0.045 BTC',
        fiat: '₦ 2,345,000',
        status: index % 2 == 0 ? 'Completed' : 'Pending',
        email: 'user$index@example.com',
        time: '2 mins ago',
      ),
    );
  }

  Widget _buildGiftCardOrders() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) => _buildOrderCard(
        type: 'Amazon Card',
        amount: '\$100.00',
        fiat: '₦ 95,000',
        status: 'Pending',
        email: 'buyer$index@gmail.com',
        time: '15 mins ago',
      ),
    );
  }

  Widget _buildOrderCard({
    required String type,
    required String amount,
    required String fiat,
    required String status,
    required String email,
    required String time,
  }) {
    Color statusColor = status == 'Completed' ? AppTheme.green500 : (status == 'Rejected' ? AppTheme.red500 : AppTheme.accentGold);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        border: Border(left: BorderSide(color: statusColor, width: 4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(type.toUpperCase(), style: AppTheme.labelXS.copyWith(color: statusColor)),
                Text(time, style: AppTheme.bodyXS.copyWith(color: AppTheme.darkTextSecondary)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(amount, style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
                    Text(fiat, style: AppTheme.bodyMD.copyWith(color: AppTheme.darkTextSecondary)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(status, style: GoogleFonts.inter(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            const Divider(height: 32, color: AppTheme.darkHighlight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(email, style: AppTheme.bodyXS.copyWith(color: AppTheme.darkTextSecondary)),
                TextButton(
                  onPressed: () {},
                  child: Text('VIEW DETAILS', style: AppTheme.bodyXS.copyWith(color: AppTheme.accentGold, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cheeseball/screens/user/bill_payment_screen.dart';
import 'package:cheeseball/screens/user/swap_screen.dart';
import 'package:cheeseball/screens/user/invoice_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _HomeView(),
    const BillPaymentScreen(),
    const SwapScreen(),
    const InvoiceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.darkBg,
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.zap), label: 'Utility'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.repeat), label: 'Swap'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.fileText), label: 'Invoice'),
        ],
        selectedItemColor: AppTheme.accentGold,
        unselectedItemColor: AppTheme.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: Image.asset('assets/CHEESEBALL 1-KDr6TQXM.png', height: 28),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(LucideIcons.bell), onPressed: () {}),
          IconButton(icon: const Icon(LucideIcons.user), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildBalanceCard(),
            const SizedBox(height: 32),
            _buildQuickActions(context),
            const SizedBox(height: 40),
            _buildLiveTickerHeader(),
            const SizedBox(height: 16),
            _buildMarketTabs(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(color: AppTheme.darkHighlight, width: 1),
        boxShadow: AppTheme.shadowMD,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Total Balance', style: AppTheme.bodyMD.copyWith(color: AppTheme.darkTextSecondary)),
              const SizedBox(width: 8),
              const Icon(LucideIcons.eyeOff, size: 16, color: AppTheme.darkTextSecondary),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '\$24,567.89',
            style: GoogleFonts.outfit(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppTheme.darkText,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildBalanceBadge('+ \$1,234.56', AppTheme.green500),
              const SizedBox(width: 12),
              _buildBalanceBadge('+ 5.23%', AppTheme.green500.withValues(alpha: 0.15), textColor: AppTheme.green500),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceBadge(String label, Color color, {Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: textColor != null ? 0.15 : 1.0),
        borderRadius: BorderRadius.circular(AppTheme.radiusXS),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor ?? AppTheme.darkBg,
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionItem(LucideIcons.plus, 'Deposit', () => Navigator.pushNamed(context, '/invoice')),
        _buildActionItem(LucideIcons.minus, 'Withdraw', () => Navigator.pushNamed(context, '/payout')),
        _buildActionItem(LucideIcons.repeat, 'Swap', () => Navigator.pushNamed(context, '/swap')),
        _buildActionItem(LucideIcons.creditCard, 'Gift Card', () => Navigator.pushNamed(context, '/giftcard')),
      ],
    );
  }

  Widget _buildActionItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.darkHighlight, width: 1),
            ),
            child: Icon(icon, color: AppTheme.accentGold, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: AppTheme.bodyXS.copyWith(color: AppTheme.darkText, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTickerHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Market Trends', style: AppTheme.headingSM.copyWith(color: AppTheme.darkText)),
            TextButton(
              onPressed: () {},
              child: Text('See All', style: AppTheme.bodySM.copyWith(color: AppTheme.accentGold)),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildMarketTabs() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppTheme.accentGold,
            indicatorWeight: 3,
            dividerColor: Colors.transparent,
            labelColor: AppTheme.accentGold,
            unselectedLabelColor: AppTheme.darkTextSecondary,
            labelStyle: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: const [
              Tab(text: 'Hot'),
              Tab(text: 'Gainers'),
              Tab(text: 'New'),
              Tab(text: '24h Vol'),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 400, // Fixed height for the ticker list
            child: TabBarView(
              children: [
                _buildMarketList('hot'),
                _buildMarketList('gainers'),
                _buildMarketList('new'),
                _buildMarketList('vol'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketList(String filter) {
    // Mock data based on filter
    List<Map<String, String>> data = [
      {'name': 'Bitcoin', 'symbol': 'BTC/USDT', 'price': '65,432.10', 'change': '+2.45%'},
      {'name': 'Ethereum', 'symbol': 'ETH/USDT', 'price': '3,456.78', 'change': '+1.12%'},
      {'name': 'Solana', 'symbol': 'SOL/USDT', 'price': '145.20', 'change': '+5.12%'},
      {'name': 'Binance Coin', 'symbol': 'BNB/USDT', 'price': '589.43', 'change': '-0.54%'},
      {'name': 'Cardano', 'symbol': 'ADA/USDT', 'price': '0.45', 'change': '+0.23%'},
    ];

    if (filter == 'gainers') {
      data.sort((a, b) => b['change']!.compareTo(a['change']!));
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return _buildLiveTickerItem(item['name']!, item['symbol']!, item['price']!, item['change']!);
      },
    );
  }
  Widget _buildLiveTickerItem(String name, String symbol, String price, String change) {
    bool isPositive = change.startsWith('+');
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
        border: Border.all(color: AppTheme.darkHighlight, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(AppTheme.radiusSM),
            ),
            child: const Icon(LucideIcons.coins, color: AppTheme.accentGold),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
                Text(symbol, style: AppTheme.bodyXS.copyWith(color: AppTheme.darkTextSecondary)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$$price', style: AppTheme.bodyMD.copyWith(color: AppTheme.darkText, fontWeight: FontWeight.bold)),
              Text(
                change,
                style: AppTheme.bodyXS.copyWith(
                  color: isPositive ? AppTheme.green500 : AppTheme.red500,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


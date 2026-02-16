import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';

class CompleteOrderPage extends StatefulWidget {
  final Map<String, dynamic>? transactionData;
  final VoidCallback onBack;
  final VoidCallback onBuyWithBankTransfer;

  const CompleteOrderPage({
    super.key,
    this.transactionData,
    required this.onBack,
    required this.onBuyWithBankTransfer,
  });

  @override
  State<CompleteOrderPage> createState() => _CompleteOrderPageState();
}

class _CompleteOrderPageState extends State<CompleteOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('Complete Order'),
        backgroundColor: AppTheme.white,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Complete Order Page'),
      ),
    );
  }
}

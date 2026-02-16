import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';

class CompleteOrderEmail extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const CompleteOrderEmail({
    super.key,
    required this.onBack,
    required this.onContinue,
  });

  @override
  State<CompleteOrderEmail> createState() => _CompleteOrderEmailState();
}

class _CompleteOrderEmailState extends State<CompleteOrderEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('Complete Order Email'),
        backgroundColor: AppTheme.white,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Complete Order Email'),
      ),
    );
  }
}

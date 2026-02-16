import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';

class OTPPage extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const OTPPage({
    super.key,
    required this.onBack,
    required this.onContinue,
  });

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: AppTheme.white,
        elevation: 0,
      ),
      body: const Center(
        child: Text('OTP Page'),
      ),
    );
  }
}

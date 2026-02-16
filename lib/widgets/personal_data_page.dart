import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';

class PersonalDataPage extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const PersonalDataPage({
    super.key,
    required this.onBack,
    required this.onContinue,
  });

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('Personal Data'),
        backgroundColor: AppTheme.white,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Personal Data Page'),
      ),
    );
  }
}

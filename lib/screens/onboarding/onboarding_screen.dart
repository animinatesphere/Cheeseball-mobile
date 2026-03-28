import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Exchange Crypto\nWith Ease',
      'subtitle': 'The most secure platform to buy, sell, and swap your digital assets instantly.',
      'icon': 'rocket',
    },
    {
      'title': 'Instant Bank\nSettlements',
      'subtitle': 'Convert your crypto or gift cards and get paid directly to your bank account in seconds.',
      'icon': 'zap',
    },
    {
      'title': 'Institutional\nGrade Security',
      'subtitle': 'Your funds are protected by multi-layer encryption and bank-level safety protocols.',
      'icon': 'shield-check',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) => _buildSlide(index),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/CHEESEBALL 1-KDr6TQXM.png',
                height: 48,
                fit: BoxFit.contain,
              ),
            ),
          ),
          _buildOverlay(),
        ],
      ),
    );
  }

  Widget _buildSlide(int index) {
    final data = _onboardingData[index];
    IconData icon;
    switch (data['icon']) {
      case 'rocket': icon = LucideIcons.rocket; break;
      case 'zap': icon = LucideIcons.zap; break;
      case 'shield-check': icon = LucideIcons.shieldCheck; break;
      default: icon = LucideIcons.rocket;
    }

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.darkSurface,
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.accentGold.withValues(alpha: 0.1), width: 2),
            ),
            child: Icon(icon, color: AppTheme.accentGold, size: 60),
          ),
          const SizedBox(height: 64),
          Text(
            data['title']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: AppTheme.darkText,
              letterSpacing: -1,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            data['subtitle']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.darkTextSecondary,
              height: 1.6,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Positioned(
      bottom: 60,
      left: 40,
      right: 40,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => _buildIndicator(index),
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < _onboardingData.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, '/welcome');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentGold,
                foregroundColor: AppTheme.darkBg,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusLG)),
              ),
              child: Text(
                _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Continue',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          if (_currentPage < _onboardingData.length - 1)
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/welcome'),
              child: Text(
                'Skip',
                style: GoogleFonts.inter(color: AppTheme.darkTextSecondary, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.accentGold : AppTheme.darkHighlight,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}


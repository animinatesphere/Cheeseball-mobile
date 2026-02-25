import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Navigation Bar
            _buildNavBar(context, isMobile),
            // Hero Section
            _buildHeroSection(context, isMobile, isTablet, isDesktop),
            // Features Section
            _buildFeaturesSection(isMobile, isTablet, isDesktop),
            // CTA Section
            _buildCtaSection(context, isMobile),
            // Footer
            _buildFooter(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar(BuildContext context, bool isMobile) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.white.withValues(alpha: 0.8),
        border: const Border(bottom: BorderSide(color: AppTheme.gray100)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Logo
            Row(
              children: [
                Image.asset(
                  'assets/CHEESEBALL 1-KDr6TQXM.png',
                  height: isMobile ? 32 : 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            const Spacer(),
            // Buttons
            if (!isMobile) ...[
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/auth'),
                child: Text('Sign In',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.gray900,
                        fontSize: 14)),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.blue600,
                  foregroundColor: AppTheme.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text('Sign Up',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w900, fontSize: 14)),
              ),
            ] else ...[
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/auth'),
                icon: const Icon(LucideIcons.logIn, color: AppTheme.gray900),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.blue600,
                  foregroundColor: AppTheme.white,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Icon(LucideIcons.rocket, size: 20),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(
      BuildContext context, bool isMobile, bool isTablet, bool isDesktop) {
    final fontSize = isMobile
        ? 32.0
        : isTablet
            ? 40.0
            : 42.0;
    final subtitleFontSize = isMobile ? 16.0 : 18.0;
    final padding = isMobile ? 16.0 : 24.0;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: padding, vertical: isMobile ? 32 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.blue50,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppTheme.blue100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: AppTheme.blue600, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text('LIVE RATES AVAILABLE',
                    style: AppTheme.labelXS.copyWith(color: AppTheme.blue600)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Heading
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.gray900,
                  letterSpacing: -1.5,
                  height: 1.1),
              children: [
                const TextSpan(text: 'The '),
                TextSpan(
                  text: 'Fastest',
                  style: TextStyle(
                    foreground: Paint()
                      ..shader = const LinearGradient(
                              colors: [AppTheme.blue600, Color(0xFF06B6D4)])
                          .createShader(const Rect.fromLTWH(0, 0, 200, 50)),
                  ),
                ),
                const TextSpan(text: ' Way to Trade Crypto.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Experience lightning-fast transactions, bank-grade security, and the best rates in Nigeria. Join thousands of users trading on Cheeseball today.',
            style: GoogleFonts.inter(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w500,
                color: AppTheme.gray500,
                height: 1.6),
          ),
          const SizedBox(height: 32),
          // CTA Buttons
          if (isMobile) ...[
            _buildPrimaryButton(context, 'Start Trading Now',
                () => Navigator.pushNamed(context, '/signup')),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.smartphone,
                  size: 20, color: AppTheme.gray400),
              label: Text('Download App',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: AppTheme.gray900)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                side: const BorderSide(color: AppTheme.gray100, width: 2),
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: _buildPrimaryButton(context, 'Start Trading Now',
                      () => Navigator.pushNamed(context, '/signup')),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(LucideIcons.smartphone,
                        size: 20, color: AppTheme.gray400),
                    label: Text('Download App',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: AppTheme.gray900)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      side: const BorderSide(color: AppTheme.gray100, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 32),
          // Stats
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppTheme.gray100))),
            child: isMobile
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('50K+',
                                  style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.gray900)),
                              Text('ACTIVE USERS', style: AppTheme.labelXS),
                            ],
                          ),
                          Container(
                              width: 1,
                              height: 40,
                              color: AppTheme.gray100,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\$10M+',
                                  style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: AppTheme.gray900)),
                              Text('TRADED VOLUME', style: AppTheme.labelXS),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('50K+',
                              style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.gray900)),
                          Text('ACTIVE USERS', style: AppTheme.labelXS),
                        ],
                      ),
                      Container(
                          width: 1,
                          height: 40,
                          color: AppTheme.gray100,
                          margin: const EdgeInsets.symmetric(horizontal: 24)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\$10M+',
                              style: GoogleFonts.inter(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: AppTheme.gray900)),
                          Text('TRADED VOLUME', style: AppTheme.labelXS),
                        ],
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 40),
          // Phone Mockup
          if (!isMobile)
            Center(
              child: Container(
                width: 280,
                height: 520,
                decoration: BoxDecoration(
                  color: AppTheme.gray900,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: AppTheme.shadowLG,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: Container(
                    decoration:
                        const BoxDecoration(gradient: AppTheme.blueGradientBR),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle)),
                            Container(
                                width: 60,
                                height: 16,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(8))),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white10)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.white24,
                                      shape: BoxShape.circle)),
                              const SizedBox(height: 16),
                              Container(
                                  width: 120,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(8))),
                              const SizedBox(height: 8),
                              Container(
                                  width: 80,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(8))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        _mockListItem(AppTheme.orange50),
                        const SizedBox(height: 8),
                        _mockListItem(AppTheme.green50),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _mockListItem(Color color) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
          color: AppTheme.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 80,
                  height: 14,
                  decoration: BoxDecoration(
                      color: AppTheme.gray100,
                      borderRadius: BorderRadius.circular(6))),
              const SizedBox(height: 6),
              Container(
                  width: 50,
                  height: 10,
                  decoration: BoxDecoration(
                      color: AppTheme.gray50,
                      borderRadius: BorderRadius.circular(6))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(bool isMobile, bool isTablet, bool isDesktop) {
    final features = [
      {
        'icon': LucideIcons.zap,
        'title': 'Instant Transactions',
        'desc':
            'Say goodbye to delays. Our automated system ensures your trades are processed in seconds.',
        'color': const Color(0xFFFEFCE8),
        'iconColor': const Color(0xFFEAB308)
      },
      {
        'icon': LucideIcons.shield,
        'title': 'Bank-Grade Security',
        'desc':
            'Your assets are protected by industry-leading encryption and secure cold storage protocols.',
        'color': AppTheme.green50,
        'iconColor': AppTheme.green500
      },
      {
        'icon': LucideIcons.globe,
        'title': 'Best Market Rates',
        'desc':
            'We scan multiple exchanges to give you the most competitive rates in Nigeria, guaranteed.',
        'color': AppTheme.blue50,
        'iconColor': AppTheme.blue600
      },
    ];

    return Container(
      color: AppTheme.gray50,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24, vertical: isMobile ? 32 : 48),
      child: Column(
        children: [
          Text('Why Choose Cheeseball?',
              style: AppTheme.headingLG.copyWith(fontSize: isMobile ? 28 : 32),
              textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
              'We provide the most reliable infrastructure for your crypto journey.',
              style: AppTheme.bodyLG,
              textAlign: TextAlign.center),
          const SizedBox(height: 40),
          ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  padding: EdgeInsets.all(isMobile ? 20 : 28),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppTheme.gray100),
                    boxShadow: AppTheme.shadowSM,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            color: f['color'] as Color,
                            borderRadius: BorderRadius.circular(16)),
                        child: Icon(f['icon'] as IconData,
                            size: 28, color: f['iconColor'] as Color),
                      ),
                      const SizedBox(height: 20),
                      Text(f['title'] as String,
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.gray900)),
                      const SizedBox(height: 8),
                      Text(f['desc'] as String,
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.gray500,
                              height: 1.6)),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCtaSection(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 28, vertical: isMobile ? 32 : 48),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Text('Ready to start your journey?',
                style: GoogleFonts.inter(
                    fontSize: isMobile ? 24 : 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.white,
                    letterSpacing: -0.5),
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(
                'Join thousands of Nigerians who trust Cheeseball for their daily crypto transactions.',
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.blue100),
                textAlign: TextAlign.center),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.white,
                  foregroundColor: AppTheme.blue600,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Create Free Account',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: AppTheme.blue600)),
                    const SizedBox(width: 8),
                    const Icon(LucideIcons.chevronRight,
                        size: 22, color: AppTheme.blue600),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(bool isMobile) {
    return Container(
      color: AppTheme.gray900,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 24, vertical: isMobile ? 32 : 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/CHEESEBALL 1-KDr6TQXM.png',
            height: 32,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          Text(
            'The most trusted cryptocurrency exchange platform for seamless buy, sell, and swap transactions in Nigeria.',
            style: GoogleFonts.inter(
                color: AppTheme.gray400, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 32),
          const Divider(color: AppTheme.gray800),
          const SizedBox(height: 16),
          Text('© 2024 Cheeseball. All rights reserved.',
              style: GoogleFonts.inter(
                  color: AppTheme.gray500,
                  fontSize: 13,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(
      BuildContext context, String text, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: AppTheme.shadowBlue,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.blue600,
          foregroundColor: AppTheme.white,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900, fontSize: 18)),
            const SizedBox(width: 8),
            const Icon(LucideIcons.arrowRight, size: 20),
          ],
        ),
      ),
    );
  }
}

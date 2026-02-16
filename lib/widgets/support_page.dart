import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  final Function(String) onNavigate;
  const SupportPage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          decoration: const BoxDecoration(gradient: AppTheme.blueGradient),
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Support Center',
                style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.white)),
            Text('We are here to help you',
                style: GoogleFonts.inter(color: AppTheme.blue200)),
          ])),
      Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            _card(
                LucideIcons.messageCircle,
                'WhatsApp Support',
                'Chat with us on WhatsApp',
                AppTheme.green500,
                () => launchUrl(Uri.parse('https://wa.me/2349100000000'))),
            _card(
                LucideIcons.mail,
                'Email Us',
                'support@cheeseball.com',
                AppTheme.blue600,
                () => launchUrl(Uri.parse('mailto:support@cheeseball.com'))),
            _card(
                LucideIcons.bookOpen,
                'Address Book',
                'Manage saved wallet addresses',
                AppTheme.orange500,
                () => onNavigate('address-book')),
            _card(LucideIcons.bell, 'Notifications', 'View your notifications',
                AppTheme.primaryBlue, () {}),
            const SizedBox(height: 24),
            Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                    color: AppTheme.gray50,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: AppTheme.gray100)),
                child: Column(children: [
                  Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                          color: AppTheme.blue50, shape: BoxShape.circle),
                      child: const Icon(LucideIcons.headphones,
                          color: AppTheme.blue600, size: 28)),
                  const SizedBox(height: 16),
                  Text('Need more help?',
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.gray900)),
                  const SizedBox(height: 4),
                  Text('Our support team is available 24/7',
                      style: AppTheme.bodySM),
                ])),
          ])),
    ]));
  }

  Widget _card(IconData icon, String title, String sub, Color color,
          VoidCallback onTap) =>
      GestureDetector(
          onTap: onTap,
          child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppTheme.gray100),
                  boxShadow: AppTheme.shadowSM),
              child: Row(children: [
                Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(18)),
                    child: Icon(icon, color: color, size: 24)),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(title,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: AppTheme.gray900)),
                      Text(sub,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppTheme.gray400,
                              fontWeight: FontWeight.w500))
                    ])),
                const Icon(LucideIcons.chevronRight,
                    color: AppTheme.gray300, size: 20),
              ])));
}

import 'package:flutter/material.dart';
import 'package:cheeseball/screens/onboarding/_intro_page.dart';

class BuyCryptoIntro extends StatelessWidget {
  const BuyCryptoIntro({super.key});
  @override
  Widget build(BuildContext context) {
    return IntroPage(
        title: 'Buy Crypto in Minutes',
        description:
            'Ready to dive into the world of digital currency? Easily purchase Bitcoin, Ethereum, and many other cryptocurrencies with your preferred payment method.',
        activeIndex: 0,
        onSkip: () => Navigator.pushNamed(context, '/sell-crypto'),
        onNext: () => Navigator.pushNamed(context, '/sell-crypto'),
        onDot: (i) {
          if (i == 1) {
            Navigator.pushNamed(context, '/sell-crypto');
          }
          if (i == 2) {
            Navigator.pushNamed(context, '/seamless-crypto');
          }
        });
  }
}

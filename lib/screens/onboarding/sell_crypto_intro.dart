import 'package:flutter/material.dart';
import 'package:cheeseball/screens/onboarding/_intro_page.dart';

class SellCryptoIntro extends StatelessWidget {
  const SellCryptoIntro({super.key});
  @override
  Widget build(BuildContext context) {
    return IntroPage(
        title: 'Sell Your Crypto Asset',
        description:
            'Need to convert your crypto back to fiat? Selling your assets is quick and secure. Choose the cryptocurrency you want to sell, and see your estimated payout instantly.',
        activeIndex: 1,
        onSkip: () => Navigator.pushNamed(context, '/seamless-crypto'),
        onNext: () => Navigator.pushNamed(context, '/seamless-crypto'),
        onDot: (i) {
          if (i == 0) {
            Navigator.pushNamed(context, '/buy-crypto');
          }
          if (i == 2) {
            Navigator.pushNamed(context, '/seamless-crypto');
          }
        });
  }
}

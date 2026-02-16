import 'package:flutter/material.dart';
import 'package:cheeseball/screens/onboarding/_intro_page.dart';

class SeamCryptoIntro extends StatelessWidget {
  const SeamCryptoIntro({super.key});
  @override
  Widget build(BuildContext context) {
    return IntroPage(
        title: 'Seamless Crypto Swaps',
        description:
            'Effortlessly exchange one cryptocurrency for another within our app. No need for multiple transactions. Simply select the coins you want to swap, and confirm.',
        activeIndex: 2,
        onSkip: () => Navigator.pushNamed(context, '/currency-change'),
        onNext: () => Navigator.pushNamed(context, '/currency-change'),
        onDot: (i) {
          if (i == 0) {
            Navigator.pushNamed(context, '/buy-crypto');
          }
          if (i == 1) {
            Navigator.pushNamed(context, '/sell-crypto');
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/screens/onboarding/onboarding_screen.dart';
import 'package:cheeseball/screens/onboarding/welcome_screen.dart';
import 'package:cheeseball/screens/onboarding/buy_crypto_intro.dart';
import 'package:cheeseball/screens/onboarding/sell_crypto_intro.dart';
import 'package:cheeseball/screens/onboarding/seam_crypto_intro.dart';
import 'package:cheeseball/screens/onboarding/signup_screen.dart';
import 'package:cheeseball/screens/auth/auth_screen.dart';
import 'package:cheeseball/screens/user/landing_page.dart';
import 'package:cheeseball/screens/user/currency_page.dart';
import 'package:cheeseball/screens/admin/pages/admin_login.dart';
import 'package:cheeseball/screens/admin/pages/admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const CheeseballApp());
}

class CheeseballApp extends StatelessWidget {
  const CheeseballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheeseball',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/buy-crypto': (context) => const BuyCryptoIntro(),
        '/sell-crypto': (context) => const SellCryptoIntro(),
        '/seamless-crypto': (context) => const SeamCryptoIntro(),
        '/auth': (context) => const AuthScreen(),
        '/currency-change': (context) => const CurrencyPage(),
        '/admin-login': (context) => const AdminLogin(),
        '/admin-dashboard': (context) => const AdminDashboard(),
        '/signup': (context) => const SignupScreen(),
      },
    );
  }
}

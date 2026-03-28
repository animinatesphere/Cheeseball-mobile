import 'package:flutter/material.dart';
import 'package:cheeseball/services/supabase_service.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/screens/onboarding/onboarding_screen.dart';
import 'package:cheeseball/screens/onboarding/welcome_screen.dart';
import 'package:cheeseball/screens/onboarding/signup_screen.dart';
import 'package:cheeseball/screens/auth/auth_screen.dart';
import 'package:cheeseball/screens/user/currency_page.dart';
import 'package:cheeseball/screens/admin/pages/admin_login.dart';
import 'package:cheeseball/screens/admin/pages/admin_dashboard.dart';
import 'package:cheeseball/screens/admin/pages/admin_orders_screen.dart';
import 'package:cheeseball/screens/admin/pages/admin_markets_screen.dart';
import 'package:cheeseball/screens/auth/forgot_password_screen.dart';
import 'package:cheeseball/screens/auth/reset_password_screen.dart';
import 'package:cheeseball/screens/user/swap_screen.dart';
import 'package:cheeseball/screens/user/dashboard_screen.dart';
import 'package:cheeseball/screens/user/gift_card_hub.dart';
import 'package:cheeseball/screens/user/invoice_screen.dart';
import 'package:cheeseball/screens/user/bill_payment_screen.dart';
import 'package:cheeseball/screens/user/payout_screen.dart';

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
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/giftcard': (context) => const GiftCardHub(),
        '/invoice': (context) => const InvoiceScreen(),
        '/bills': (context) => const BillPaymentScreen(),
        '/payout': (context) => const PayoutScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/auth': (context) => const AuthScreen(),
        '/currency-change': (context) => const CurrencyPage(),
        '/admin-login': (context) => const AdminLogin(),
        '/admin-dashboard': (context) => const AdminDashboard(),
        '/admin-orders': (context) => const AdminOrdersScreen(),
        '/admin-markets': (context) => const AdminMarketsScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/reset-password': (context) {
          final email = ModalRoute.of(context)!.settings.arguments as String;
          return ResetPasswordScreen(email: email);
        },
        '/swap': (context) => const SwapScreen(),
      },
    );
  }
}

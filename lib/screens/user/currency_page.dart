import 'package:flutter/material.dart';
import 'package:cheeseball/theme/app_theme.dart';
import 'package:cheeseball/widgets/currency_rates.dart';
import 'package:cheeseball/widgets/currency_detail.dart';
import 'package:cheeseball/widgets/swap_crypto.dart';
import 'package:cheeseball/widgets/confirm_swap.dart';
import 'package:cheeseball/widgets/awaiting_deposit.dart';
import 'package:cheeseball/widgets/buy_cryptocurrency.dart';
import 'package:cheeseball/widgets/buy_crypto_address.dart';
import 'package:cheeseball/widgets/complete_order_page.dart';
import 'package:cheeseball/widgets/complete_order_email.dart';
import 'package:cheeseball/widgets/otp_page.dart';
import 'package:cheeseball/widgets/personal_data_page.dart';
import 'package:cheeseball/widgets/bank_transfer_details.dart';
import 'package:cheeseball/widgets/address_book.dart';
import 'package:cheeseball/widgets/support_page.dart';
import 'package:cheeseball/widgets/history_page.dart';
import 'package:cheeseball/widgets/alert_rates_page.dart';
import 'package:cheeseball/widgets/bottom_nav.dart';
import 'package:cheeseball/widgets/modals/crypto_exchange_modal.dart';
import 'package:cheeseball/widgets/modals/exchange_page_modal.dart';
import 'package:cheeseball/widgets/modals/payment_success_modal.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});
  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  String _currentPage = 'rates';
  Map<String, dynamic>? _selectedCurrency;
  String? _showModal;
  Map<String, dynamic>? _transactionData;

  void _navigate(String page) {
    setState(() {
      _currentPage = page;
      _showModal = null;
      if (page == 'rates') _selectedCurrency = null;
    });
  }

  void _goBack() {
    setState(() {
      _currentPage = 'rates';
      _selectedCurrency = null;
    });
  }

  Widget _buildPage() {
    switch (_currentPage) {
      case 'rates':
        return CurrencyRates(
          onSelectCurrency: (currency) => setState(() { _selectedCurrency = currency; _currentPage = 'detail'; }),
          onNavigate: _navigate,
        );
      case 'detail':
        return CurrencyDetail(
          currency: _selectedCurrency,
          onBack: _goBack,
          onExchange: () => setState(() => _currentPage = 'swap'),
        );
      case 'swap':
        return SwapCrypto(
          onBack: _goBack,
          onSwap: (data) => setState(() { _transactionData = data; _currentPage = 'confirm'; }),
          onNavigate: _navigate,
        );
      case 'confirm':
        return ConfirmSwap(
          transactionData: _transactionData,
          onBack: () => setState(() => _currentPage = 'swap'),
          onConfirm: () => setState(() => _currentPage = 'awaiting'),
        );
      case 'awaiting':
        return AwaitingDeposit(transactionData: _transactionData, onBack: _goBack);
      case 'buy':
        return BuyCryptocurrency(
          onBack: _goBack,
          onExchange: (data) => setState(() { _transactionData = data; _showModal = 'crypto-exchange'; }),
          onNavigate: _navigate,
        );
      case 'buy-address':
        return BuyCryptoAddress(
          transactionData: _transactionData,
          onBack: () => setState(() => _currentPage = 'buy'),
          onCreateExchange: (address) => setState(() { _transactionData = {...?_transactionData, 'wallet_address': address}; _showModal = 'exchange-page'; }),
        );
      case 'complete-order':
        return CompleteOrderPage(
          transactionData: _transactionData,
          onBack: () => setState(() => _currentPage = 'buy-address'),
          onBuyWithBankTransfer: () => setState(() => _currentPage = 'bank-transfer'),
        );
      case 'complete-order-email':
        return CompleteOrderEmail(
          onBack: () => setState(() => _currentPage = 'complete-order'),
          onContinue: () => setState(() => _currentPage = 'otp'),
        );
      case 'otp':
        return OTPPage(
          onBack: () => setState(() => _currentPage = 'complete-order-email'),
          onContinue: () => setState(() => _currentPage = 'personal-data'),
        );
      case 'personal-data':
        return PersonalDataPage(
          onBack: () => setState(() => _currentPage = 'otp'),
          onContinue: () => setState(() => _currentPage = 'bank-transfer'),
        );
      case 'bank-transfer':
        return BankTransferDetails(
          transactionData: _transactionData,
          onBack: () => setState(() => _currentPage = 'complete-order'),
          onContinue: () => setState(() => _showModal = 'payment-success'),
        );
      case 'address-book':
        return AddressBook(onBack: () => setState(() => _currentPage = 'support'));
      case 'support':
        return SupportPage(onNavigate: _navigate);
      case 'history':
        return HistoryPage(onNavigate: _navigate);
      case 'alert-rates':
        return AlertRatesPage(onBack: _goBack);
      default:
        return CurrencyRates(onSelectCurrency: (c) => setState(() { _selectedCurrency = c; _currentPage = 'detail'; }), onNavigate: _navigate);
    }
  }

  Widget? _buildModal() {
    switch (_showModal) {
      case 'crypto-exchange':
        return CryptoExchangeModal(
          onAccept: () => setState(() { _showModal = null; _currentPage = 'buy-address'; }),
          onClose: () => setState(() => _showModal = null),
        );
      case 'exchange-page':
        return ExchangePageModal(
          onAccept: () => setState(() { _showModal = null; _currentPage = 'complete-order'; }),
          onClose: () => setState(() => _showModal = null),
        );
      case 'payment-success':
        return PaymentSuccessModal(
          onClose: () => setState(() { _showModal = null; _currentPage = 'rates'; }),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: _buildPage(),
          ),
          if (_buildModal() != null) _buildModal()!,
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: BottomNav(currentPage: _currentPage, onNavigate: _navigate),
          ),
        ],
      ),
    );
  }
}

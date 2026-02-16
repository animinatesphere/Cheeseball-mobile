# Cheeseball - Flutter Crypto Exchange App

A full Flutter conversion of the Cheeseball React cryptocurrency exchange application.

## Project Structure

```
lib/
├── main.dart                          # App entry + routing
├── theme/
│   └── app_theme.dart                 # Colors, typography, shadows (matches Tailwind)
├── services/
│   ├── supabase_service.dart          # Supabase client + all API methods
│   ├── crypto_api_service.dart        # CoinGecko API integration
│   └── paystack_config.dart           # Paystack public key
├── screens/
│   ├── onboarding/
│   │   ├── onboarding_screen.dart     # Splash/landing
│   │   ├── welcome_screen.dart        # User/Admin login selection
│   │   ├── buy_crypto_intro.dart      # Onboarding step 1
│   │   ├── sell_crypto_intro.dart     # Onboarding step 2
│   │   ├── seam_crypto_intro.dart     # Onboarding step 3
│   │   └── _intro_page.dart           # Shared intro page template
│   ├── auth/
│   │   └── auth_screen.dart           # Email OTP login via Supabase
│   ├── user/
│   │   ├── landing_page.dart          # Marketing landing page
│   │   └── currency_page.dart         # Main app container (state machine)
│   └── admin/
│       └── pages/
│           ├── admin_login.dart       # Admin authentication
│           └── admin_dashboard.dart   # Admin panel with stats
├── widgets/
│   ├── bottom_nav.dart                # Floating bottom navigation
│   ├── currency_rates.dart            # Live crypto market rates grid
│   ├── currency_detail.dart           # Individual currency details
│   ├── swap_crypto.dart               # Crypto-to-crypto swap
│   ├── confirm_swap.dart              # Swap confirmation + address input
│   ├── awaiting_deposit.dart          # Deposit address with QR code
│   ├── buy_cryptocurrency.dart        # Fiat-to-crypto purchase
│   ├── buy_crypto_address.dart        # Wallet address for delivery
│   ├── complete_order_page.dart       # Payment method selection
│   ├── complete_order_email.dart      # Email verification
│   ├── otp_page.dart                  # OTP verification
│   ├── personal_data_page.dart        # Identity verification
│   ├── bank_transfer_details.dart     # Bank transfer instructions
│   ├── history_page.dart              # Transaction history
│   ├── support_page.dart              # Support center
│   ├── address_book.dart              # Saved wallet addresses
│   ├── alert_rates_page.dart          # Price alerts
│   └── modals/
│       ├── crypto_exchange_modal.dart # Terms acceptance
│       ├── exchange_page_modal.dart   # Order confirmation
│       └── payment_success_modal.dart # Payment success
```

## Setup Instructions

### Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / Xcode (for emulators)

### Installation

1. **Navigate to project:**
   ```bash
   cd cheeseball_flutter
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on device/emulator:**
   ```bash
   flutter run
   ```

## Technology Stack

| React (Original)       | Flutter (Converted)         |
|------------------------|-----------------------------|
| React 19               | Flutter 3.x                 |
| Supabase JS Client     | supabase_flutter            |
| React Router           | Navigator + named routes    |
| Tailwind CSS           | Custom AppTheme + BoxDecoration |
| Lucide React           | lucide_icons                |
| react-paystack         | flutter_paystack_plus       |
| Google Fonts (CSS)     | google_fonts                |
| CoinGecko fetch        | http package                |
| react-qr-code          | qr_flutter                  |

## Backend Configuration

- **Supabase URL:** `https://bkqcnozcoeqnlsyqgzee.supabase.co`
- **Paystack Key:** `pk_live_404913f1bedf74e461de973fc81447e1d6128c5e`

## Database Tables
- `profiles` - User profiles
- `currencies` - Cryptocurrency listings
- `transactions` - Exchange transactions
- `notifications` - User notifications
- `income_logs` - Revenue tracking
- `system_status` - System health

## Features
- Email OTP authentication (Supabase)
- Live cryptocurrency market rates
- Crypto-to-crypto swaps
- Fiat-to-crypto purchases (Paystack)
- Transaction history with filters
- Admin dashboard with order management
- WhatsApp support integration
- Address book for saved wallets
- Price alerts

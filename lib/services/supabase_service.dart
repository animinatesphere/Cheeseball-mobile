import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://bkqcnozcoeqnlsyqgzee.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJrcWNub3pjb2VxbmxzeXFnemVlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA4Mzg4ODQsImV4cCI6MjA4NjQxNDg4NH0.mVDzVBuQ23-YGxqF5dJWM4DMFRYE7iNeYWpZrOvWu2k';

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  // --- Auth ---
  static Future<void> signInWithOtp(String email) async {
    await client.auth.signInWithOtp(email: email);
  }

  static Future<AuthResponse> verifyOtp(String email, String token) async {
    return await client.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.magiclink,
    );
  }

  static Session? get currentSession => client.auth.currentSession;
  static User? get currentUser => client.auth.currentUser;

  // --- Profiles ---
  static Future<Map<String, dynamic>?> getProfile(String userId) async {
    final response = await client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return response;
  }

  static Future<void> updateProfile(String userId, Map<String, dynamic> updates) async {
    await client.from('profiles').update(updates).eq('id', userId);
  }

  // --- Currencies ---
  static Future<List<Map<String, dynamic>>> getCurrencies() async {
    final response = await client
        .from('currencies')
        .select()
        .order('is_active', ascending: false)
        .order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>?> createCurrency(Map<String, dynamic> data) async {
    final response = await client.from('currencies').insert(data).select().single();
    return response;
  }

  static Future<void> updateCurrency(String id, Map<String, dynamic> updates) async {
    await client.from('currencies').update(updates).eq('id', id);
  }

  // --- Transactions ---
  static Future<List<Map<String, dynamic>>> getTransactions() async {
    final response = await client
        .from('transactions')
        .select('''
          *,
          profiles:user_id (full_name, email),
          from_currency:currencies!from_currency_id (symbol, icon_url),
          to_currency:currencies!to_currency_id (symbol, icon_url)
        ''')
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<List<Map<String, dynamic>>> getUserTransactions(String userId) async {
    final response = await client
        .from('transactions')
        .select('''
          *,
          from_currency:currencies!from_currency_id (symbol, icon_url),
          to_currency:currencies!to_currency_id (symbol, icon_url)
        ''')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<void> updateTransactionStatus(String id, String status) async {
    await client.from('transactions').update({'status': status}).eq('id', id);
  }

  static Future<Map<String, dynamic>?> createTransaction(Map<String, dynamic> data) async {
    final response = await client.from('transactions').insert(data).select().single();
    return response;
  }

  // --- User Portfolio ---
  static Future<Map<String, double>> getUserPortfolio(String userId) async {
    final transactions = await getUserTransactions(userId);
    final portfolio = <String, double>{};

    for (final t in transactions) {
      if ((t['status'] as String?)?.toLowerCase() != 'approved') continue;

      final toSymbol = t['to_currency']?['symbol'] as String?;
      final toAmount = double.tryParse(t['to_amount']?.toString() ?? '0') ?? 0;
      if (toSymbol != null) {
        portfolio[toSymbol] = (portfolio[toSymbol] ?? 0) + toAmount;
      }

      final fromSymbol = t['from_currency']?['symbol'] as String?;
      final fromAmount = double.tryParse(t['from_amount']?.toString() ?? '0') ?? 0;
      if (fromSymbol != null) {
        portfolio[fromSymbol] = (portfolio[fromSymbol] ?? 0) - fromAmount;
      }
    }

    return portfolio;
  }

  // --- Notifications ---
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final response = await client
        .from('notifications')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>?> createNotification(Map<String, dynamic> data) async {
    final response = await client.from('notifications').insert(data).select().single();
    return response;
  }

  // --- Income Logs ---
  static Future<List<Map<String, dynamic>>> getIncomeLogs() async {
    final response = await client
        .from('income_logs')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // --- System Status ---
  static Future<List<Map<String, dynamic>>> getSystemStatus() async {
    final response = await client
        .from('system_status')
        .select()
        .order('name', ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }

  // --- Admin Stats ---
  static Future<Map<String, dynamic>> getAdminStats() async {
    final orderCount = await client
        .from('transactions')
        .select('id')
        .count(CountOption.exact);

    final currencyCount = await client
        .from('currencies')
        .select('id')
        .eq('is_active', true)
        .count(CountOption.exact);

    return {
      'orderCount': orderCount.count,
      'currencyCount': currencyCount.count,
      'volume': '5,824k',
    };
  }
}

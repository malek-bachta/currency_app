import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _usernameKey = 'username';
  static const String _fromCurrencyKey = 'fromCurrency';
  static const String _toCurrencyKey = 'toCurrency';
  static const String _inputAmountKey = 'inputAmount';

  static Future<void> saveUsername(String username) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_usernameKey, username);
    } catch (e) {
      print('Error saving username: $e');
    }
  }

  static Future<String?> getUsername() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_usernameKey);
    } catch (e) {
      print('Error getting username: $e');
      return null;
    }
  }

  static Future<void> saveConversionPreferences(
      String fromCurrency, String toCurrency) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_fromCurrencyKey, fromCurrency);
      await prefs.setString(_toCurrencyKey, toCurrency);
    } catch (e) {
      print('Error saving conversion preferences: $e');
    }
  }

  static Future<Map<String, String>> getConversionPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String fromCurrency = prefs.getString(_fromCurrencyKey) ?? 'USD';
      final String toCurrency = prefs.getString(_toCurrencyKey) ?? 'EUR';

      return {'fromCurrency': fromCurrency, 'toCurrency': toCurrency};
    } catch (e) {
      print('Error getting conversion preferences: $e');
      return {'fromCurrency': 'USD', 'toCurrency': 'EUR'};
    }
  }

  static Future<void> saveInputAmount(String inputAmount) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(_inputAmountKey, inputAmount);
    } catch (e) {
      print('Error saving input amount: $e');
    }
  }

  static Future<String?> getInputAmount() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_inputAmountKey);
    } catch (e) {
      print('Error getting input amount: $e');
      return null;
    }
  }

  static Future<bool> hasSavedData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_usernameKey) &&
          prefs.containsKey(_fromCurrencyKey) &&
          prefs.containsKey(_toCurrencyKey);
    } catch (e) {
      print('Error checking saved data: $e');
      return false;
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:currecy_App/models/Currency.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DataClass extends ChangeNotifier {
  List<Currency> currencies = [];
  Currency? selectedFromCurrency;
  Currency? selectedToCurrency;

  Future<void> fetchCurrencies() async {
    final url =
        'https://api.fastforex.io/currencies?api_key=38e8071029-c818e7a246-s502e0';

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));
      print('Response status code: ${response.statusCode}');

      print('Raw response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('currencies') &&
            data['currencies'] is Map<String, dynamic>) {
          final Map<String, dynamic> currenciesData = data['currencies'];

          currencies = currenciesData.entries.map((entry) {
            return Currency(
              name: entry.value,
              code: entry.key,
            );
          }).toList();

          selectedFromCurrency ??= currencies.first;
          selectedToCurrency ??= currencies.last;
        } else {
          print(
              'Invalid data structure. Expected a Map<String, dynamic> under "currencies".');
        }
      } else {
        print(
            'Failed to fetch currencies. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      if (e is TimeoutException) {
        print(
            'Timeout fetching currencies. Please check your internet connection.');
      } else {
        print('Error fetching currencies: $e');
      }
    }

    print('Currencies after fetch: $currencies');
    notifyListeners();
  }

  Future<double?> convertCurrency(
      String fromCurrency, String toCurrency, double amount) async {
    // Validation checks
    if (fromCurrency.isEmpty || toCurrency.isEmpty || amount <= 0) {
      print('Invalid input for conversion');
      return null;
    }

    final url =
        'https://api.fastforex.io/convert?from=$fromCurrency&to=$toCurrency&amount=$amount&api_key=38e8071029-c818e7a246-s502e0';

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 20));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('result')) {
          return data['result'][toCurrency];
        } else {
          print('Conversion result not found in the response.');
          return null;
        }
      } else {
        print(
            'Failed to convert currency. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error during currency conversion: $e');
      return null;
    }
  }

  void swapCurrencies() {
    final temp = selectedFromCurrency;
    selectedFromCurrency = selectedToCurrency;
    selectedToCurrency = temp;

    notifyListeners();
  }
}

import 'dart:async';

import 'package:currency_App/Services/api_service.dart';
import 'package:currency_App/models/Currencies.dart';
import 'package:currency_App/models/Currency.dart';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DataClass extends ChangeNotifier {
  List<Currency> currencies = [];
  Currency? selectedFromCurrency;
  Currency? selectedToCurrency;

  final Dio _dio = Dio();

  DataService get _dataService => DataService(_dio);

  Future<void> fetchCurrencies() async {
    try {
      print('Fetching currencies...');
      final CurrenciesResponse data =
          await _dataService.fetchCurrencies("0765383ee4-94c1440c54-s6xsit");
      print('Currencies fetched successfully: $data');

      // currencies = data;
      selectedFromCurrency ??= currencies.first;
      selectedToCurrency ??= currencies.last;
    } catch (e) {
      print('Error during fetchCurrencies: $e');
    }

    notifyListeners();
  }

  Future<double?> convertCurrency(
      String fromCurrency, String toCurrency, double amount) async {
    try {
      final Map<String, dynamic> data = await _dataService.convertCurrency(
          fromCurrency, toCurrency, amount, "0765383ee4-94c1440c54-s6xsit");
      print('Conversion result: $data');
      if (data.containsKey('result')) {
        return data['result'][toCurrency];
      } else {
        print('Conversion result not found in the response.');
        return null;
      }
    } catch (e) {
      print('Error during convertCurrency: $e');
    }
  }

  void swapCurrencies() {
    final temp = selectedFromCurrency;
    selectedFromCurrency = selectedToCurrency;
    selectedToCurrency = temp;

    notifyListeners();
  }

  bool isCurrencyValid(String currencyCode) {
    String upperCaseCurrencyCode = currencyCode.toUpperCase();

    return currencies.any(
        (currency) => currency.code.toUpperCase() == upperCaseCurrencyCode);
  }
}

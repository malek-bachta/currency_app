import 'package:currency_App/models/Currency.dart';

// class Currencies {
//   final Map<String, Currency> currencyMap;

//   Currencies({required this.currencyMap});

 
//  factory Currencies.formJson(Map<String, dynamic> json) {
//     final Map<String, Currency> currencyMap = {};
//     json.forEach((key, value) {
//       currencyMap[key] = Currency.fromJson(value);
//     });
//     return Currencies(currencyMap: currencyMap);
//   }
// }

class CurrenciesResponse {
  Map<String, Currency> currencies;

  CurrenciesResponse({required this.currencies});

  factory CurrenciesResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> currenciesJson = json['currencies'];
    Map<String, Currency> currencies = currenciesJson.map((key, value) =>
        MapEntry(key, Currency.fromJson(Map<String, dynamic>.from(value))));

    return CurrenciesResponse(
      currencies: currencies,
    );
  }
}
import 'package:currency_App/models/Currency.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<Currency> currencies;
  final Currency? selectedCurrency;
  final ValueChanged<Currency?> onChanged;
  final String labelText;

  CustomDropdown({
    required this.currencies,
    required this.selectedCurrency,
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<Currency>(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            fillColor: const Color(0xFFECF0F1),
            filled: true,
          ),
          value: selectedCurrency,
          onChanged: onChanged,
          items:
              currencies.map<DropdownMenuItem<Currency>>((Currency currency) {
            return DropdownMenuItem<Currency>(
              value: currency,
              child: Text("${currency.name} (${currency.code})"),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return currencies.map<Widget>((Currency currency) {
              return Text(currency.code);
            }).toList();
          },
        ),
      ],
    );
  }
}

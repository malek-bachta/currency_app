// custom_dropdown.dart
import 'package:currecy_App/models/Currency.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<Currency> currencies;
  final Currency? selectedCurrency;
  final ValueChanged<Currency?> onChanged;
  final String LabelText;

  CustomDropdown({
    required this.currencies,
    required this.selectedCurrency,
    required this.onChanged,
    required this.LabelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: TextEditingController(text: selectedCurrency?.code),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: LabelText,
          ),
          onChanged: (value) {
            final selected = currencies.firstWhere(
              (currency) => currency.code.toLowerCase() == value.toLowerCase(),
              orElse: () => currencies.first,
            );
            onChanged(selected);
          },
        ),
      ],
    );
  }
}

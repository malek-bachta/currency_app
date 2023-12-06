import 'package:currency_App/helpers/shared_preferences_helper.dart';
import 'package:currency_App/porviders/DataClass.dart';
import 'package:flutter/material.dart';

class SettingsPopup extends StatefulWidget {
  final VoidCallback onPopupClosed; // Add this line

  const SettingsPopup({Key? key, required this.onPopupClosed})
      : super(key: key);

  @override
  _SettingsPopupState createState() =>
      _SettingsPopupState(onPopupClosed: onPopupClosed); // Update this line
}

class _SettingsPopupState extends State<SettingsPopup> {
  late TextEditingController inputUsernameController;
  late TextEditingController fromCurrencyController;
  late TextEditingController toCurrencyController;

  final VoidCallback onPopupClosed;

  _SettingsPopupState({required this.onPopupClosed});

  final dataClass = DataClass();
  String conversionResult = '';

  @override
  void initState() {
    super.initState();

    inputUsernameController = TextEditingController();
    fromCurrencyController = TextEditingController();
    toCurrencyController = TextEditingController();

    loadSavedData();
    dataClass.fetchCurrencies();
  }

  void loadSavedData() async {
    final Map<String, String> conversionPreferences =
        await SharedPreferencesHelper.getConversionPreferences();

    final String? inputUsername = await SharedPreferencesHelper.getUsername();

    setState(() {
      inputUsernameController.text = inputUsername ?? '';
      fromCurrencyController.text = conversionPreferences['fromCurrency'] ?? '';
      toCurrencyController.text = conversionPreferences['toCurrency'] ?? '';
    });
  }

  void _UpdateData() async {
    try {
      String inputUsername = inputUsernameController.text;
      String fromCurrency = fromCurrencyController.text.toUpperCase();
      String toCurrency = toCurrencyController.text.toUpperCase();

      if (!validateInput()) return;

      if (inputUsername.isNotEmpty) {
        await SharedPreferencesHelper.saveUsername(inputUsername);
      }

      await SharedPreferencesHelper.saveConversionPreferences(
          fromCurrency, toCurrency);

      Navigator.pop(context);
    } catch (e) {
      print("error");
    }
  }

  bool validateInput() {
    if (fromCurrencyController.text.isEmpty ||
        toCurrencyController.text.isEmpty ||
        inputUsernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something is missing"),
        ),
      );
      return false;
    }
    if (!dataClass.isCurrencyValid(fromCurrencyController.text) ||
        !dataClass.isCurrencyValid(toCurrencyController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid currency"),
        ),
      );
      return false;
    }
    if (fromCurrencyController.text == toCurrencyController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select different currencies"),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECF0F1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: inputUsernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  fillColor: const Color(0xFFECF0F1),
                  filled: true,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: fromCurrencyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'From',
                        fillColor: const Color(0xFFECF0F1),
                        filled: true,
                        labelStyle: TextStyle(
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.swap_horiz,
                      color: const Color(0xFF2C3E50),
                    ),
                    onPressed: () {
                      setState(() {
                        var temp = fromCurrencyController.text;
                        fromCurrencyController.text = toCurrencyController.text;
                        toCurrencyController.text = temp;
                      });
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: toCurrencyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'To',
                        fillColor: const Color(0xFFECF0F1),
                        filled: true,
                        labelStyle: TextStyle(
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () =>
                          {Navigator.of(context).pop(), onPopupClosed()},
                    ),
                    TextButton(
                      child: Text("Save", style: TextStyle(color: Colors.red)),
                      onPressed: () {
                        _UpdateData();
                        onPopupClosed();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

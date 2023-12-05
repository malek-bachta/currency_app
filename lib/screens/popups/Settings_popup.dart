import 'package:currecy_App/helpers/shared_preferences_helper.dart';
import 'package:currecy_App/porviders/DataClass.dart';
import 'package:flutter/material.dart';

class SettingsPopup extends StatefulWidget {
  const SettingsPopup({Key? key}) : super(key: key);

  @override
  _SettingsPopupState createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  late TextEditingController inputUsernameController;
  late TextEditingController fromCurrencyController;
  late TextEditingController toCurrencyController;

  final dataClass = DataClass();
  String conversionResult = '';

  @override
  void initState() {
    super.initState();

    inputUsernameController = TextEditingController();
    fromCurrencyController = TextEditingController();
    toCurrencyController = TextEditingController();

    loadSavedData();
  }

  void loadSavedData() async {
    // Retrieve saved data from SharedPreferences
    final Map<String, String> conversionPreferences =
        await SharedPreferencesHelper.getConversionPreferences();

    final String? inputUsername = await SharedPreferencesHelper.getUsername();

    setState(() {
      inputUsernameController.text = inputUsername ?? '';
      fromCurrencyController.text = conversionPreferences['fromCurrency'] ?? '';
      toCurrencyController.text = conversionPreferences['toCurrency'] ?? '';
    });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: const Color(0xFF2C3E50),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Retrieve values from the text controllers
                  String inputUsername = inputUsernameController.text;
                  String fromCurrency =
                      fromCurrencyController.text.toUpperCase();
                  String toCurrency = toCurrencyController.text.toUpperCase();

                  // Validate and save the inputUsername
                  if (inputUsername.isNotEmpty) {
                    await SharedPreferencesHelper.saveUsername(inputUsername);
                  }

                  // Save the conversion preferences
                  await SharedPreferencesHelper.saveConversionPreferences(
                      fromCurrency, toCurrency);

                  // Close the settings popup
                  Navigator.pop(context);
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF3498DB),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

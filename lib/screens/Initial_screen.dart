import 'package:currency_App/models/Currency.dart';
import 'package:currency_App/porviders/DataClass.dart';
import 'package:currency_App/helpers/shared_preferences_helper.dart';
import 'package:currency_App/screens/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_App/screens/Home_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<DataClass>(context, listen: false).fetchCurrencies();
  }

  void _saveData() async {
    final String enteredUsername = usernameController.text;
    final DataClass dataClass = Provider.of<DataClass>(context, listen: false);

    if (enteredUsername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a username"),
        ),
      );
    } else if (dataClass.selectedFromCurrency?.code ==
        dataClass.selectedToCurrency?.code) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select different currencies"),
        ),
      );
    } else {
      final String enteredUsername = usernameController.text;
      await SharedPreferencesHelper.saveUsername(enteredUsername);
      print('Entered Username: $enteredUsername');

      final String? username = await SharedPreferencesHelper.getUsername();
      print('Username: $username');

      final DataClass dataClass =
          Provider.of<DataClass>(context, listen: false);
      SharedPreferencesHelper.saveConversionPreferences(
        dataClass.selectedFromCurrency?.code ?? 'USD',
        dataClass.selectedToCurrency?.code ?? 'EUR',
      );

      final Map<String, String> conversionPreferences =
          await SharedPreferencesHelper.getConversionPreferences();
      print('From Currency: ${conversionPreferences['fromCurrency']}');
      print('To Currency: ${conversionPreferences['toCurrency']}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 190.0,
              height: 190.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFECF0F1),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/currencylogo.png',
                  width: 160.0,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                fillColor: const Color(0xFFECF0F1),
                filled: true,
              ),
            ),
            SizedBox(height: 20.0),
            Consumer<DataClass>(
              builder: (context, dataClass, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        currencies: dataClass.currencies,
                        selectedCurrency: dataClass.selectedFromCurrency,
                        onChanged: (Currency? newValue) {
                          dataClass.selectedFromCurrency = newValue!;
                          print('Selected From Currency: ${newValue?.name}');
                        },
                        labelText: 'From',
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.swap_horiz,
                        color: const Color(0xFF2C3E50),
                      ),
                      onPressed: () {
                        dataClass.swapCurrencies();
                      },
                    ),
                    Expanded(
                      child: CustomDropdown(
                        currencies: dataClass.currencies,
                        selectedCurrency: dataClass.selectedToCurrency,
                        onChanged: (Currency? newValue) {
                          dataClass.selectedToCurrency = newValue!;
                        },
                        labelText: 'To',
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _saveData();
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
            ),
          ],
        ),
      ),
    );
  }
}

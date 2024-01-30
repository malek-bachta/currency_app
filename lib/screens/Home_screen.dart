import 'package:currency_App/models/Conversion.dart';
import 'package:currency_App/porviders/DataClass.dart';
import 'package:currency_App/screens/Archive_screen.dart';
import 'package:currency_App/screens/popups/Settings_popup.dart';
import 'package:currency_App/helpers/shared_preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController inputAmountController;
  late TextEditingController fromCurrencyController;
  late TextEditingController toCurrencyController;
  late TextEditingController conversionResultController;

  late TextEditingController inputUsernameController;

  final dataClass = DataClass();
  String conversionResult = '';

  @override
  void initState() {
    super.initState();
    loadSavedData();

    inputUsernameController = TextEditingController();

    inputAmountController = TextEditingController();
    fromCurrencyController = TextEditingController();
    toCurrencyController = TextEditingController();
    conversionResultController = TextEditingController();

    dataClass.fetchCurrencies();
  }

  void loadSavedData() async {
    final Map<String, String> conversionPreferences =
        await SharedPreferencesHelper.getConversionPreferences();
    final String? inputAmount = await SharedPreferencesHelper.getInputAmount();

    final String? inputUsername = await SharedPreferencesHelper.getUsername();

    setState(() {
      inputAmountController.text = inputAmount ?? '';
      fromCurrencyController.text = conversionPreferences['fromCurrency'] ?? '';
      toCurrencyController.text = conversionPreferences['toCurrency'] ?? '';

      inputUsernameController.text = inputUsername ?? '';
    });
  }

  void _showSettingsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingsPopup(onPopupClosed: () {
          _refreshData();
        });
      },
    );
  }

  void performConversion() async {
    try {
      String fromCurrency = fromCurrencyController.text.toUpperCase();
      String toCurrency = toCurrencyController.text.toUpperCase();

      double amount = double.tryParse(inputAmountController.text) ?? 0.0;

      if (!validateInput()) return;

      double? result =
          await dataClass.convertCurrency(fromCurrency, toCurrency, amount);

      setState(() {
        conversionResult =
            result != null ? result.toString() : 'Error in conversion';
        conversionResultController.text = conversionResult;

        fromCurrencyController.text = fromCurrency;
        toCurrencyController.text = toCurrency;
      });
      FocusScope.of(context).unfocus();
    } catch (e) {
      print("aaaaaaaaaaaa");
      setState(() {
        conversionResult = 'Error: ${e.toString()}';
      });
    }
  }

  void SaveConversion() async {
    String fromCurrency = fromCurrencyController.text.toUpperCase();
    String toCurrency = toCurrencyController.text.toUpperCase();

    double amount = double.tryParse(inputAmountController.text) ?? 0.0;
    double? result =
        await dataClass.convertCurrency(fromCurrency, toCurrency, amount);
    if (result != null) {
      Conversion newConversion = Conversion(
        from: fromCurrency,
        to: toCurrency,
        inputAmount: amount.toString(),
        result: result.toString(),
        dateTime: DateTime.now(),
      );
      await SharedPreferencesHelper.saveConversionRecord(newConversion);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("conversion saved ! "),
      ));
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      loadSavedData();
      inputAmountController.clear();
      fromCurrencyController.clear();
      toCurrencyController.clear();

      conversionResult = '';
    });
  }

  bool validateInput() {
    if (fromCurrencyController.text.isEmpty ||
        toCurrencyController.text.isEmpty ||
        inputAmountController.text.isEmpty) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E50),
        title: Row(
          children: [
            Image.asset(
              'assets/icons/logo.png',
              width: 32.0,
              height: 32.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'Currency Converter',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.archive,
              color: Colors.white,
            ),
            onPressed: () async {
              List<Conversion> conversions =
                  await SharedPreferencesHelper.getConversionRecords();

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ArchiveScreen(conversions: conversions)),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              _showSettingsPopup(context);
            },
          ),
        ],
      ),
      body: Consumer<DataClass>(
        builder: (context, dataClass, child) {
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
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
                    RichText(
                      text: TextSpan(
                        text: 'Username: ',
                        style: const TextStyle(
                          color: const Color(0xFF2C3E50),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '${inputUsernameController.text}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 1, 112, 116),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: fromCurrencyController,
                            decoration: const InputDecoration(
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
                              fromCurrencyController.text =
                                  toCurrencyController.text;
                              toCurrencyController.text = temp;
                            });
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: toCurrencyController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'To',
                              fillColor: Color(0xFFECF0F1),
                              filled: true,
                              labelStyle: TextStyle(
                                color: Color(0xFF2C3E50),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: inputAmountController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Input Amount',
                        fillColor: const Color(0xFFECF0F1),
                        filled: true,
                        labelStyle: TextStyle(
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        performConversion();
                      },
                      child: Text(
                        'convert',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 11, 197, 36),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 232, 245, 233),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromARGB(255, 200, 230, 201)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.compare_arrows,
                              color: Color.fromARGB(255, 11, 197, 36)),
                          SizedBox(width: 10),
                          Text(
                            'Result: $conversionResult',
                            style: TextStyle(
                              color: Color.fromARGB(255, 30, 42, 42),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            SaveConversion();
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
                        ElevatedButton(
                          onPressed: () {
                            _refreshData();
                          },
                          child: Text(
                            'Discard',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFE74C3C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

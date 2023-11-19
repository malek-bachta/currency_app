import 'package:currecy_App/models/conversion_model.dart';
import 'package:currecy_App/screens/Archive_screen.dart';
import 'package:currecy_App/screens/popups/Settings_popup.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static Conversion staticConversion =
      Conversion(inputAmount: "1.0", from: 'USD', to: 'EUR', result: "0.85");

  void _showSettingsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SettingsPopup(); // Use the SettingsPopup widget
      },
    );
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ArchiveScreen(conversions: [staticConversion]),
                ),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input Amount',
                fillColor: const Color(0xFFECF0F1),
                filled: true,
                labelStyle: TextStyle(
                  color: const Color(0xFF2C3E50),
                ),
              ),
              // Handle text input 1 changes
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'From',
                      fillColor: const Color(0xFFECF0F1),
                      filled: true,
                      labelStyle: TextStyle(
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                    // Handle text input 1 changes
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.swap_horiz,
                    color: const Color(0xFF2C3E50),
                  ),
                  onPressed: () {
                    // Add logic for swapping 'From' and 'To'
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'To',
                      fillColor: const Color(0xFFECF0F1),
                      filled: true,
                      labelStyle: TextStyle(
                        color: const Color(0xFF2C3E50),
                      ),
                    ),
                    // Handle text input 2 changes
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Use RichText for a more professional look
            RichText(
              text: TextSpan(
                text: 'Result: ',
                style: TextStyle(
                  color: const Color(0xFF2C3E50),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Your Result',
                    style: TextStyle(
                      color: const Color(0xFF3498DB),
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
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
                    // Add logic for currency conversion
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
                    // Add logic for discarding changes
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
    );
  }
}

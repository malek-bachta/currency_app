import 'package:flutter/material.dart';

class SettingsPopup extends StatefulWidget {
  const SettingsPopup({Key? key}) : super(key: key);

  @override
  _SettingsPopupState createState() => _SettingsPopupState();
}

class _SettingsPopupState extends State<SettingsPopup> {
  String username = '';
  String fromCurrency = '';
  String toCurrency = '';

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  fillColor: const Color(0xFFECF0F1),
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'From',
                        fillColor: const Color(0xFFECF0F1), // Light Gray
                        filled: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          fromCurrency = value;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz),
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
                      ),
                      onChanged: (value) {
                        setState(() {
                          toCurrency = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add logic for saving settings
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

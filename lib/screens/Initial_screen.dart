import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key});

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
                color: const Color(0xFFECF0F1), // Light Gray
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                fillColor: const Color(0xFFECF0F1), // Light Gray
                filled: true,
              ),
              // Handle text input 1 changes
            ),
            SizedBox(height: 20.0),
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
                    // Handle text input 1 changes
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.swap_horiz,
                    color: const Color(0xFF2C3E50), // Dark Blue Gray
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
                      fillColor: const Color(0xFFECF0F1), // Light Gray
                      filled: true,
                    ),
                    // Handle text input 2 changes
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Add logic for currency conversion
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF3498DB), // Dodger Blue
              ),
            ),
          ],
        ),
      ),
    );
  }
}

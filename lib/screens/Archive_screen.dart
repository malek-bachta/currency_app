import 'package:currecy_App/models/Conversion.dart';
import 'package:flutter/material.dart';

class ArchiveScreen extends StatelessWidget {
  final List<Conversion> conversions;

  const ArchiveScreen({Key? key, required this.conversions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E50),
        iconTheme: IconThemeData(
            color: Colors.white), 

        title: Row(
          children: [
            Image.asset(
              'assets/icons/logo.png',
              width: 32.0,
              height: 32.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'Archive',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the list of conversions
            for (var conversion in conversions)
              _buildConversionTile(conversion),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionTile(Conversion conversion) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        title: Text('From: ${conversion.from} To: ${conversion.to}'),
        subtitle: Text(
            'Input: ${conversion.inputAmount} Result: ${conversion.result}'),
      ),
    );
  }
}

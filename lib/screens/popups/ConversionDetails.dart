import 'package:flutter/material.dart';
import 'package:currency_App/models/Conversion.dart';
import 'package:intl/intl.dart';

class ConversionDetails extends StatelessWidget {
  final Conversion conversion;

  const ConversionDetails({Key? key, required this.conversion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('HH:mm:ss dd/MM/yyyy').format(conversion.dateTime);

    return AlertDialog(
      title: Text('Conversion Details'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('From: ${conversion.from}'),
            Text('To: ${conversion.to}'),
            Text('Input: ${conversion.inputAmount}'),
            Text('Result: ${conversion.result}'),
            Text('Date: ${formattedDate}')
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

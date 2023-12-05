import 'package:currecy_App/screens/popups/ConversionDetails.dart';
import 'package:flutter/material.dart';
import 'package:currecy_App/models/Conversion.dart';
import 'package:currecy_App/screens/popups/delete_confirmation.dart'; // Adjust the import path as needed

class ConversionTile extends StatelessWidget {
  final Conversion conversion;
  final VoidCallback onDelete;

  const ConversionTile({
    Key? key,
    required this.conversion,
    required this.onDelete,
  }) : super(key: key);

  void _showConversionDetails(BuildContext context, Conversion conversion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConversionDetails(conversion: conversion);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      child: ListTile(
        title: Text('From: ${conversion.from} To: ${conversion.to}'),
        subtitle: Text(
            'Input: ${conversion.inputAmount}'), // Adjust the field name as per your Conversion model
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: () {
          _showConversionDetails(context, conversion);
        },
      ),
    );
  }
}

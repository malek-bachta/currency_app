import 'package:currecy_App/helpers/shared_preferences_helper.dart';
import 'package:currecy_App/screens/popups/delete_confirmation.dart';
import 'package:currecy_App/screens/widgets/ConversionTile.dart';
import 'package:flutter/material.dart';
import 'package:currecy_App/models/Conversion.dart';

class ArchiveScreen extends StatefulWidget {
  final List<Conversion> conversions;

  ArchiveScreen({Key? key, required this.conversions}) : super(key: key);

  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  List<Conversion> conversions = [];

  @override
  void initState() {
    super.initState();
    _loadConversions();
  }

  void _loadConversions() async {
    var loadedConversions =
        await SharedPreferencesHelper.getConversionRecords();
    setState(() {
      conversions = loadedConversions;
    });
  }

  void _handleDelete(int index) async {
    await SharedPreferencesHelper.deleteConversionRecord(index);
    _loadConversions(); // Refresh the list after deletion
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmation(
          onConfirmDelete: () => _confirmDelete(index),
        );
      },
    );
  }

  void _confirmDelete(int index) async {
    await SharedPreferencesHelper.deleteConversionRecord(index);
    _loadConversions(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E50),
        iconTheme: IconThemeData(color: Colors.white),
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
      body: ListView.builder(
        itemCount: conversions.length,
        itemBuilder: (context, index) {
          return ConversionTile(
            conversion: conversions[index],
            onDelete: () => _showDeleteConfirmation(context, index),
          );
        },
      ),
    );
  }
}

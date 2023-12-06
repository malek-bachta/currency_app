import 'package:currency_App/porviders/DataClass.dart';
import 'package:currency_App/screens/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  runApp(
    ChangeNotifierProvider(
      create: (context) => DataClass(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SplashScreen(),
    );
  }
}

import 'package:currency_App/porviders/DataClass.dart';
import 'package:currency_App/screens/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataClass(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Blog App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

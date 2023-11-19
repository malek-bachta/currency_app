
import 'package:currecy_App/porviders/DataClass.dart';
import 'package:currecy_App/screens/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  // Initialize SharedPreferences

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataClass()),
        // Add more providers for user authentication, offline posts, etc. as needed.
      ],
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

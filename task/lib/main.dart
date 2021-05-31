import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/Views/Login/login_screen.dart';
import 'package:task/Views/Login/offers_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((value) => runApp(MyApp(value)));
}

class MyApp extends StatelessWidget {
  final SharedPreferences? preferences;
  MyApp(this.preferences);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practical',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: this.preferences!.getString('token') != null
          ? OffersPage()
          : LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import './pages/homepage.dart';
// import 'dart:html';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        cardColor: Colors.indigo[50],
        accentColor: Colors.indigoAccent[800],
        fontFamily: 'OpenSans',
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              subtitle1: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              subtitle2: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 14,
              ),
              button: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

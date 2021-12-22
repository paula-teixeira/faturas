import 'package:faturas/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Faturas());
  Intl.defaultLocale = 'pt_BR';
}

class Faturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        ),
      home: HomeScreen(),
    );
  }
}
import 'package:faturas/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Faturas());
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
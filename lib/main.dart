import 'package:flutter/material.dart';
import 'calculatorScreen.dart';

void main() {
  return runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: calculatorScreen(),
    );
  }
}


// main.dart - Main of the BMI Calculator app.
//
// Copyright (c) 2025 Ercan Ersoy.
//
// This file is part of the BMI Calculator app.
//
// Used ChatGPT GPT-4o and GitHub Copilot GPT-4o for writting this program.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: _buildDarkTheme(),
      home: const BMICalculator(),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.grey,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.black,
        secondaryContainer: Colors.black,
      ),
      focusColor: Colors.blue,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Colors.blue,
        selectionHandleColor: Colors.black,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmi;

  void _calculateBMI() {
    final double heightCm = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    if (heightCm <= 0 || weight <= 0) {
      _showErrorSnackbar('Please enter valid height and weight.');
      return;
    }

    final double height = heightCm / 100;
    setState(() {
      _bmi = weight / (height * height);
    });
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Theme(
                    data: ThemeData(
                      scaffoldBackgroundColor: Colors.grey,
                      textTheme: const TextTheme(
                        bodyMedium: TextStyle(color: Colors.black),
                        bodyLarge: TextStyle(color: Colors.black),
                        titleMedium: TextStyle(color: Colors.black),
                      ),
                    ),
                    child: const LicensePage(
                      applicationName: 'BMI Calculator',
                      applicationVersion: '1.0.0',
                      applicationLegalese: '© 2025 Ercan Ersoy',
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(
              controller: _heightController,
              label: 'Height (cm)',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _weightController,
              label: 'Weight (kg)',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 20),
            if (_bmi != null)
              Text(
                'Your BMI is ${_bmi!.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
              ),
            const SizedBox(height: 20),
            _buildAboutText(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildAboutText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'This BMI Calculator helps you to calculate your Body Mass Index (BMI) based on your height and weight. '
        'Enter your height in centimeters and weight in kilograms, then press the "Calculate BMI" button to see your BMI.\r\n\r\n'
        'Copyright © 2025 Ercan Ersoy\r\n'
        'This app licensed under MIT License.\r\n\r\n'
        'The logo of this app borrowed from Tango Icon Set, published as Public Domain.\r\n\r\n'
        'The other licenses can be found in the "Licenses" page.',
        style: TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}

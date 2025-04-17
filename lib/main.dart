import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Your SplashScreen widget


void main() {
  runApp(const ExpenseLocatorApp());
}

class ExpenseLocatorApp extends StatelessWidget {
  const ExpenseLocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Locator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash_screen': (context) => const SplashScreen(),
      },
    );
  }
}

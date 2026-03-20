import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const ServiGoApp());
}

class ServiGoApp extends StatelessWidget {
  const ServiGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ServiGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6B35),
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}
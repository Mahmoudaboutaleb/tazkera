import 'package:flutter/material.dart';
import 'package:tazkera/config/theme/colors.dart';
import 'package:tazkera/features/Auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tazkera',
      theme: ThemeData(
        primaryColor: ColorsManager.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tazkera/features/Auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // جعل شريط الحالة شفافًا
          statusBarIconBrightness:
              Brightness.dark, // تغيير لون الرموز في شريط الحالة
          statusBarBrightness:
              Brightness.light, // اختيار وضع الإضاءة لشريط الحالة
        ),
      );
    });

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

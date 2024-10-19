import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tazkera/config/theme/colors.dart';
import 'package:tazkera/features/home-screen/home_page.dart';
import 'package:tazkera/features/Auth/login_page.dart';
import 'package:tazkera/core/utils/firebase_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.setupFirebase();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorsManager.darkerGreen,
      statusBarBrightness: Brightness.light,
    ),
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');
  String? password = prefs.getString('password');

  Widget defaultHome;
  if (email != null && password != null) {
    bool success = await FirebaseService.login(
      email: email,
      password: password,
    );
    defaultHome = success ? const HomeScreen() : const LoginScreen();
  } else {
    defaultHome = const LoginScreen();
  }

  runApp(MyApp(defaultHome: defaultHome));
}

class MyApp extends StatelessWidget {
  final Widget defaultHome;

  const MyApp({super.key, required this.defaultHome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tazkera',
      home: defaultHome,
    );
  }
}

import 'package:flutter/material.dart';

import 'signup_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLock = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    "assets/images/login.png",
                    width: 200,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 300,
                    child: TextSelectionTheme(
                      data: const TextSelectionThemeData(
                        cursorColor: Color.fromRGBO(76, 174, 159, 1.0),
                        selectionColor:
                            Color.fromRGBO(76, 174, 159, 0.3), // لون التحديد
                        selectionHandleColor: Color.fromRGBO(
                            76, 174, 159, 1.0), // لون العلامات الجانبية للتحديد
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textDirection:
                            TextDirection.rtl, // اتجاه النص من اليمين لليسار
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(76, 174, 159, 1.0),
                          ),
                          hintText: 'example@domain.com',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromRGBO(76, 174, 159, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(76, 174, 159, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextSelectionTheme(
                      data: const TextSelectionThemeData(
                        cursorColor: Color.fromRGBO(76, 174, 159, 1.0),
                        selectionColor:
                            Color.fromRGBO(76, 174, 159, 0.3), // لون التحديد
                        selectionHandleColor: Color.fromRGBO(
                            76, 174, 159, 1.0), // لون العلامات الجانبية للتحديد
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: isLock,
                        textDirection:
                            TextDirection.rtl, // اتجاه النص من اليمين لليسار
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isLock = !isLock;
                                });
                              },
                              icon: Icon(
                                isLock
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: const Color.fromRGBO(76, 174, 159, 1.0),
                              )),
                          labelText: 'كلمة المرور',
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(76, 174, 159, 1.0),
                          ),
                          hintText: '********',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromRGBO(76, 174, 159, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromRGBO(76, 174, 159, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("لا تمتلك حساباً؟",
                          textDirection: TextDirection.rtl),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'سجل الآن',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(76, 174, 159, 1.0),
                            decoration: TextDecoration.underline,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(76, 174, 159, 1.0),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          // await login();
                        }
                      },
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

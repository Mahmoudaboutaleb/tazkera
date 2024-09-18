// ignore_for_file: use_build_context_synchronously, use_super_parameters

import 'package:flutter/material.dart';
import 'package:tazkera/core/utils/firebase_services.dart';
import 'package:tazkera/features/home-screen/home_screen.dart';
import 'package:tazkera/features/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLock = true;
  bool isConfirmLock = true;

  @override
  void initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController.addListener(() {
      setState(() {});
    });
    confirmPasswordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      bool success = await FirebaseService.signUp(
        name: userNameController.text.trim(),
        email: emailController.text.trim(),
        username: userNameController.text.trim(),
        password: passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('خطأ في التسجيل')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/sign_up.png',
                    width: 250,
                    height: 250,
                  ),
                  const Text(
                    'إنشاء حساب',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 2, 87, 32)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'يرجى ملء النموذج التالي لإنشاء حساب.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF003312)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: userNameController,
                          labelText: "إسم المستخدم",
                          hintText: "",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال الإسم';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: emailController,
                          labelText: "البريد الإلكتروني",
                          hintText: "example@domain.com",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: passwordController,
                          obscureText: isLock,
                          labelText: 'كلمة المرور',
                          hintText: '********',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isLock = !isLock;
                              });
                            },
                            icon: passwordController.text.isEmpty
                                ? const SizedBox.shrink()
                                : Icon(
                                    isLock
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color:
                                        const Color.fromRGBO(76, 174, 159, 1.0),
                                  ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: confirmPasswordController,
                          obscureText: isConfirmLock,
                          labelText: 'تأكيد كلمة المرور',
                          hintText: '********',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmLock = !isConfirmLock;
                              });
                            },
                            icon: confirmPasswordController.text.isEmpty
                                ? const SizedBox.shrink()
                                : Icon(
                                    isConfirmLock
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color:
                                        const Color.fromRGBO(76, 174, 159, 1.0),
                                  ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value != passwordController.text) {
                              return 'كلمة المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        isLoading
                            ? const CircularProgressIndicator(
                                color: Color.fromRGBO(76, 174, 159, 1.0),
                                backgroundColor: Color(0xFF003312),
                              )
                            : SizedBox(
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
                                  onPressed: _signUp,
                                  child: const Text(
                                    'تسجيل',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

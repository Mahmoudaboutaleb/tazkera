import 'package:flutter/material.dart';
import 'package:tazkera/features/widgets/custom_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

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
                  // const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'يرجى ملء النموذج التالي لإنشاء حساب.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF003312)),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      icon: Icon(
                        !isLock
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color.fromRGBO(76, 174, 159, 1.0),
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
                      icon: Icon(
                        isConfirmLock
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color.fromRGBO(76, 174, 159, 1.0),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

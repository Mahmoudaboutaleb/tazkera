// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tazkera/config/theme/colors.dart';
import 'package:tazkera/config/theme/styles.dart';
import 'package:tazkera/core/helpers/spacing.dart';
import 'package:tazkera/core/helpers/string_manager.dart';
import 'package:tazkera/core/utils/firebase_services.dart';
import 'package:tazkera/features/Auth/login_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:tazkera/features/tazkara-page/tazkera_page.dart'; // Add this import

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool?> confirmLogout(BuildContext context) async {
      return await showDialog<bool?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('تأكيد الخروج'),
            content: const Text('هل أنت متأكد أنك تريد الخروج من التطبيق؟'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // رفض الخروج
                },
                child: const Text('لا'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // تأكيد الخروج
                },
                child: const Text('نعم'),
              ),
            ],
          );
        },
      );
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          bool? shouldLogout = await confirmLogout(context);
          if (shouldLogout == true) {
            await FirebaseService.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                confirmLogout(context);
              },
              child: Image.asset("assets/images/log out.png"),
            )
          ],
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: SizedBox(
                    height: 250,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            AppStrings.tazeraDescription,
                            textStyle: TextStyles.font18GreenMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                verticalSpace(20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.green,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TazkeraPage()),
                    );
                  },
                  child: Text(
                    'ذكر',
                    style: TextStyles.font16WhiteSemiBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tazkera/config/theme/colors.dart';
import 'package:tazkera/config/theme/styles.dart';
import 'package:tazkera/core/helpers/spacing.dart';
import 'package:tazkera/core/helpers/string_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyles.font24WhiteBold,
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30,
              ))
        ],
        backgroundColor: ColorsManager.green,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                child: SizedBox(
                  height: 250,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: AnimatedTextKit(animatedTexts: [
                      TyperAnimatedText(AppStrings.tazeraDescription,
                          textStyle: TextStyles.font18GreenMedium,
                          textAlign: TextAlign.center)
                    ]),
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
                  //
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
    );
  }
}

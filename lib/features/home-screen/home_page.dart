import 'package:flutter/material.dart';
import 'package:tazkera/config/theme/colors.dart';
import 'package:tazkera/config/theme/styles.dart';
import 'package:tazkera/core/helpers/spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Card(
              child: Text('تطبيق ديني'),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tazkera/config/theme/colors.dart';
import 'package:tazkera/config/theme/styles.dart';
import 'package:tazkera/features/widgets/log_out_icon.dart';

class TazkeraScreen extends StatefulWidget {
  const TazkeraScreen({super.key});

  @override
  State<TazkeraScreen> createState() => _TazkeraScreenState();
}

class _TazkeraScreenState extends State<TazkeraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'و ذكر فان الذكرى تنفع المؤمنين',
          style: TextStyles.font24WhiteBold.copyWith(fontSize: 20),
        ),
        actions: const [LogOutIcon()],
        backgroundColor: ColorsManager.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // shape: const LinearBorder(),

        // shape: const CircleBorder(),
        backgroundColor: ColorsManager.green,

        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Placeholder()));
        },
      ),
    );
  }
}

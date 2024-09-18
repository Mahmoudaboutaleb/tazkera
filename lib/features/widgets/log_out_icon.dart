import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tazkera/features/Auth/login_page.dart';

class LogOutIcon extends StatelessWidget {
  const LogOutIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('هل حقا تريد الخروج ؟'),
            content: const Text('سوف تخرج من حسابك؟'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context); // Close the dialog without logging out
                },
                child: const Text('لا'),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context); // Close the dialog and log out
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: const Text('نعم'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(
        Icons.exit_to_app,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

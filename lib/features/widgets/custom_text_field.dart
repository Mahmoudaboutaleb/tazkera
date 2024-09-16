import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final IconButton? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: TextSelectionTheme(
        data: const TextSelectionThemeData(
          cursorColor: Color.fromRGBO(76, 174, 159, 1.0),
          selectionColor: Color.fromRGBO(76, 174, 159, 0.3),
          selectionHandleColor: Color.fromRGBO(76, 174, 159, 1.0),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Color.fromRGBO(76, 174, 159, 1.0),
            ),
            hintText: hintText,
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
            final validationError = validator?.call(value);
            return validationError?.isEmpty ?? true ? null : validationError;
          },
        ),
      ),
    );
  }
}

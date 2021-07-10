import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool isPassword;
  final String? error;

  const InputField({
    Key? key,
    required this.controller,
    required this.focus,
    this.isPassword = false,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focus,
      obscureText: isPassword,
      decoration: InputDecoration(
        errorText: error,
        hintText: isPassword ? 'Password...' : 'someone@somewhere.com',
      ),
    );
  }
}

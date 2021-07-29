import 'package:flutter/material.dart';

/// Stylized [TextField] to declutter views.
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
      style: TextStyle(
        color: Colors.blueGrey,
        fontWeight: FontWeight.w600,
      ),
      controller: controller,
      focusNode: focus,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: InputBorder.none,
        errorText: error,
        hintText: isPassword ? 'Password...' : 'someone@somewhere.com',
      ),
    );
  }
}

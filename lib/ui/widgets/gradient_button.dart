import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final List<Color> colors;

  const GradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.colors = const [Colors.tealAccent, Colors.pink],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: colors,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: Size.fromHeight(50),
        ),
      ),
    );
  }
}

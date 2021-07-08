import 'package:flutter/material.dart';

/// Wrapper to intercept back button presses with a custom dialog.
class BackButtonInterception extends StatelessWidget {
  final Widget child;
  const BackButtonInterception({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: child,
        onWillPop: () {
          // TODO: Implement save dialog
          return Future.value(false);
        });
  }
}

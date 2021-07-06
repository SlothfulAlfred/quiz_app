import 'package:flutter/material.dart';
import 'package:quiz_app/ui/router.dart' as router;
import 'package:quiz_app/ui/routing_constants.dart';

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      initialRoute: loginRoute,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}

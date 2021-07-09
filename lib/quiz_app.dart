import 'package:flutter/material.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/ui/router.dart' as router;
import 'package:quiz_app/ui/routing_constants.dart';

import 'locator.dart';

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().nav,
      title: 'Quiz App',
      initialRoute: loginRoute,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}

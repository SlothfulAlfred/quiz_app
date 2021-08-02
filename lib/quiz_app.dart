import 'package:flutter/material.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/services/scaffold_service.dart';
import 'package:quiz_app/ui/router.dart' as router;
import 'package:quiz_app/ui/routing_constants.dart';
import 'package:quiz_app/ui/shared/theme.dart';

import 'locator.dart';

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      navigatorKey: locator<NavigationService>().navKey,
      scaffoldMessengerKey: locator<ScaffoldService>().key,
      title: 'Quiz App',
      initialRoute: loginRoute,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/models/api_models.dart' show User;
import 'package:quiz_app/core/services/authentication.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/services/scaffold_service.dart';
import 'package:quiz_app/ui/router.dart' as router;
import 'package:quiz_app/ui/routing_constants.dart';

import 'locator.dart';

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provides global access to the stream of users for all descendants of
    // [MaterialApp]. This is preferred to providing it at a lower level
    // (i.e. For a single View / ViewModel) because more than one part of
    // the app needs access to this information
    // (Home page, Settings page, Logout page, to name a few).
    // The initial data is null since the user hasn't signed in yet.
    return StreamProvider<User>(
      create: (_) => locator<AuthenticationService>().userStream.stream,
      initialData: User.anonymous(),
      child: MaterialApp(
        navigatorKey: locator<NavigationService>().navKey,
        scaffoldMessengerKey: locator<ScaffoldService>().key,
        title: 'Quiz App',
        initialRoute: loginRoute,
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}

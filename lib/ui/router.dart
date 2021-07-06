import 'package:flutter/material.dart';
import 'package:quiz_app/ui/routing_constants.dart';

import 'views/login_view.dart';

/// Handles all of the route management for the app
///
/// Arguments should be passed through [RouteSettings.arguments]
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginRoute:
      return MaterialPageRoute(builder: (_) => LoginView());
    case homeRoute:
      // TODO: Return homeRoute
      return MaterialPageRoute(builder: (_) => LoginView());
    default:
      // TODO: Return UndefinedRoute
      return MaterialPageRoute(builder: (_) => LoginView());
  }
}

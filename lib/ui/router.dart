import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/ui/routing_constants.dart';
import 'package:quiz_app/ui/views/home_view.dart';
import 'package:quiz_app/ui/views/login_view.dart';
import 'package:quiz_app/ui/views/quiz_view.dart';

/// Handles all of the route management for the app
///
/// Arguments should be passed through [RouteSettings.arguments]
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginRoute:
      return MaterialPageRoute(builder: (_) => LoginView());
    case homeRoute:
      return MaterialPageRoute(builder: (_) => HomeView());
    case quizRoute:
      var quiz = settings.arguments as Quiz;
      return MaterialPageRoute(builder: (_) => QuizView(quiz: quiz));
    default:
      // TODO: Return UndefinedRoute
      return MaterialPageRoute(builder: (_) => LoginView());
  }
}

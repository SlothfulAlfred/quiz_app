import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/ui/routing_constants.dart';
import 'package:quiz_app/ui/views/view.dart';

/// Handles all of the route management for the app
///
/// Arguments should be passed through [RouteSettings.arguments]
Route<dynamic> onGenerateRoute(RouteSettings settings) {
  late Widget page;
  switch (settings.name!) {
    case loginRoute:
      page = LoginView();
      break;

    case homeRoute:
      page = HomeView();
      break;

    case quizRoute:
      var quiz = settings.arguments as Quiz;
      page = QuizView(quiz: quiz);
      break;

    case registrationRoute:
      page = RegistrationView();
      break;

    case settingsRoute:
      page = SettingsView();
      break;

    case errorRoute:
      var args = settings.arguments as Map;
      page = ErrorView(
        error: args['error'],
        exception: args['exception'],
      );
      break;

    default:
      // Handle nested flow.
      if (settings.name!.startsWith(questionsRoutePrefix)) {
        // extract arguments
        var args = settings.arguments as Map;
        var quiz = args['quiz'] as Quiz;

        page = QuestionsView(quiz: quiz);
      } else {
        page = ErrorView(
          undefined: true,
        );
      }
  }

  return MaterialPageRoute(builder: (_) => page);
}

/// Handles route generation for the nested Questions flow.
Route nestedGenerateRoute(RouteSettings settings) {
  // Animations needed to animate route transition.
  Animatable<Offset> pushAnimation = Tween(
    begin: Offset(0.0, 1.0),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeInOut));

  Animatable<Offset> popAnimation = Tween(
    begin: Offset.zero,
    end: Offset(0.0, -1.0),
  ).chain(CurveTween(curve: Curves.easeInOut));

  Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // The outer [SlideTransition] animates the incoming route
    // (The route being pushed onto the screen), and the inner
    // [SlideTransition] animates the outgoing route (The route
    // that was popped off of the screen).
    return SlideTransition(
      child: SlideTransition(
        position: popAnimation.animate(secondaryAnimation),
        child: child,
      ),
      position: pushAnimation.animate(animation),
    );
  }

  Widget page;

  switch (settings.name!) {
    case questionsRouteInProgress:
      // Extract arguments.
      var args = settings.arguments! as Map;
      Function onChoiceSelected = args['onChoiceSelected'];
      Question question = args['question'];

      page = QuestionsViewPage(
        question: question,
        onChoiceSelected: onChoiceSelected,
      );
      break;

    case questionsRouteStart:
      page = QuestionsStartPage();
      break;

    case questionsRouteFinished:
      page = QuestionsFinishedPage();
      break;

    default:
      page = ErrorView(undefined: true);
  }
  return (page is ErrorView)
      ? MaterialPageRoute(builder: (_) => page)
      : PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: _buildTransition,
        );
}

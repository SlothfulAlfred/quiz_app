import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/viewModels/questions_view_model.dart';
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

        page = QuestionsViewModel(
          quiz: quiz,
        );
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
  switch (settings.name!) {
    case questionsRouteInProgress:
      // Extract arguments.
      var args = settings.arguments! as Map;
      Function onChoiceSelected = args['onChoiceSelected'];
      Question question = args['question'];

      // return route with animated transition.
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => QuestionsViewPage(
          question: question,
          onChoiceSelected: onChoiceSelected,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 2.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: Curves.easeOut),
          );
          return SlideTransition(
            child: child,
            position: tween.animate(animation),
          );
        },
      );

    case questionsRouteStart:
      return MaterialPageRoute(builder: (_) => QuestionsStartPage());

    case questionsRouteFinished:
      return MaterialPageRoute(builder: (_) => QuestionsFinishedPage());

    default:
      return MaterialPageRoute(
        builder: (_) => ErrorView(
          undefined: true,
        ),
      );
  }
}

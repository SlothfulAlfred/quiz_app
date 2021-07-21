import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/services/scaffold_service.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/routing_constants.dart';
import 'package:quiz_app/ui/router.dart';

/// A hybrid class handling quiz questions containing
/// mostly business logic but some UI logic.
///
/// This class doesn't conform to the MVVM architecture
/// nor does it strictly fit the single-responsibility principle.
/// However, I think this is the best design option.
///
/// Trying to separate the ViewModel's business logic from the
/// View's UI logic lead to the issue of the ViewModel rebuilding
/// every time a new page was pushed. This is obviously a
/// problem because it makes many unnecessary API calls and
/// loses track of the quiz progress each time. In exchange for
/// fixing this problem, this class holds a minimal amount of UI
/// logic, which is a [Scaffold] and an [AppBar].
///
/// I could not think of a way to get around the ViewModel rebuilding
/// each time a new page was pushed. The ViewModel must be registered
/// as a [registerFactoryParam] because it needs a unique instance
/// for each unique quiz. On the other hand, there is no way to
/// maintain the same instance of the ViewModel between the different
/// pages in the nested flow. If the consumer/provider logic was put in each
/// page, it would create a new instance every time. If the consumer/provider
/// logic was put in the class that held the [Scaffold] and [Navigator], it
/// could not be passed down to its children.

// TODO: Huge refactor for [QuestionsViewModel].
// - revert to [QuestionsView] which holds the [Scaffold] and [Navigator].
// - require a [QuestionsViewModel] parameter for all questionsRoute pages.
// - In [QuestionsViewModel], pass [this] as an argument during navigation.
// - Instantiate a [QuestionsViewModel] inside [QuestionsView].
//
//     ------------------                -----------------------
//     | QuestionsView  | -- request --> |  QuestionsViewModel |
//     | => QuestionsVM | --  nav    --> |                     |
//     ------------------                -----------------------
//                                          |
//                                     passes *this
//                                          |
//     ------------- <--- push pages  ------<
//     |   New     |
//     | View Page |
//     -------------
//
class QuestionsViewModel extends StatelessWidget {
  final Api _api = locator<Api>();
  // It is okay to set this to static since get_it returns a lazy
  // singleton anyway so it is always the same instance.
  static final NavigationService _nav = locator<NavigationService>();
  final ScaffoldService _snackBar = locator<ScaffoldService>();

  late final List<Question> questions;
  final Quiz quiz;

  QuestionsViewModel({required this.quiz}) {
    _onInit(quiz.id);
  }

  static get nestedNavKey => _nav.nestedNavKey;

  void _onInit(String id) async {
    questions = await _api.getQuestions(id);

    // Checks if the quiz is already completed
    if (questions.length == 0) {
      _completeQuiz();
      return;
    }
    pushNextQuestion();
  }

  void onChoiceSelected(Choice choice, [SnackBar? snackBar]) {
    if (choice.isCorrect) {
      pushNextQuestion();
    } else {
      _snackBar.showSnackBar(snackBar!);
    }
  }

  void pushNextQuestion() {
    try {
      int newIndex = Random().nextInt(questions.length);
      _nav.nestedPushReplacementNamed(
        questionsRouteInProgress,
        arguments: <String, dynamic>{
          'question': questions[newIndex],
          'onChoiceSelected': onChoiceSelected,
        },
      );
      questions.removeAt(newIndex);
    } catch (e) {
      // An error has occurred, check if the quiz is completed.
      if (questions.length == 0) {
        _completeQuiz();
      } else {
        // An unexpected error has occurred.
        _nav.pushReplacementNamed(errorRoute, arguments: {'error': e});
      }
    }
  }

  void _completeQuiz() {
    _nav.nestedPushReplacementNamed(questionsRouteFinished);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppbar(),
      body: Navigator(
        key: QuestionsViewModel.nestedNavKey,
        onGenerateRoute: nestedGenerateRoute,
        initialRoute: questionsRouteStart,
      ),
    );
  }

  PreferredSizeWidget _createAppbar() {
    return AppBar(
      title: Text(quiz.title),
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: _nav.pop,
      ),
    );
  }
}

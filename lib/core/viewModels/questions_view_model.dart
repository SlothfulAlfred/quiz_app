import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/services/scaffold_service.dart';
import 'package:quiz_app/core/services/services.dart';
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
/// Another possible solution to this issue would be to "raise the state"
/// by designing a class to handle the Navigator and contain an instance
/// of the ViewModel. This class would then pass down a reference to the
/// ViewModel when pushing the nested routes.
/// ```dart
/// class NestedFlow extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return BaseView<QuestionsViewModel, void, void>(
///       builder: (BuildContext, model, child) => Scaffold(
///         appBar: _buildAppBar(),
///         body: Navigator(
///           onGenerateRoute: model.onGenerateRoute,
///           key: model.nestedNavKey,
///           ...
///         ),
///       ),
///     );
///   }
/// }
///
/// // Inside the ViewModel
/// class QuestionsViewModel extends BaseModel {
///   final NavigationService _nav = locator<NavigationService>();
///   ...
///   void pushNextQuestion() {
///     try {
///       // Do something here.
///       _nav.nestedPushReplacementNamed(
///         'route',
///         arguemnts: {
///           'model': this,
///           'argumentName': 'whateverOtherArguments',
///         },
///       );
///     } catch (e) {
///       // Handle any errors that come up.
///     }
///   }
///
///   Route<dynamic> onGenerateRoute(RouteSettings settings, {dynamic arguments}) {
///     switch (settings.name!) {
///       case 'some route name':
///         QuestionsViewModel model = arguments['model'];
///         var whateverOtherArguments = arguments['argumentName'];
///         return MaterialPageRoute(builder: () => SomeRouteView(
///           model: model,
///           otherArgument: whateverOtherArguments,
///          ),
///       );
///       ...
///     }
///   }
/// }
/// ```
// ignore: must_be_immutable
class QuestionsViewModel extends StatelessWidget {
  final Api _api = locator<Api>();
  // It is okay to set this to static since get_it returns a lazy
  // singleton anyway so it is always the same instance.
  static final NavigationService _nav = locator<NavigationService>();
  final ScaffoldService _snackBar = locator<ScaffoldService>();
  final UserService _user = locator<UserService>();

  late final List<Question> questions;

  /// Keeps track of indices of [questions] that house unanswered
  /// question. Used for random question selection.
  final List<int> _choosable = [];
  final Quiz quiz;

  /// Keeps track of the current question so that it can be marked correct.
  /// Will show a warning that the class is not immutable, that is okay, this
  /// is not related to the UI in any way so it does not need to be immutable.
  int? currentQuestionIndex;

  QuestionsViewModel({required this.quiz}) {
    _onInit(quiz.id);
  }

  static get nestedNavKey => _nav.nestedNavKey;

  void _onInit(String id) async {
    questions = await _api.getQuestions(id);
    _filterAnswered();

    // Checks if the quiz is already completed
    if (_choosable.length == 0) {
      _completeQuiz();
      return;
    }
    pushNextQuestion();
  }

  void pushNextQuestion() {
    _snackBar.removeCurrentSnackBar();

    try {
      // Tries to push a new question page onto the stack and
      // keep track of the question if succesfully pushed.
      int newIndex = Random().nextInt(_choosable.length);
      currentQuestionIndex = _choosable[newIndex];
      _nav.nestedPushReplacementNamed(
        questionsRouteInProgress,
        arguments: <String, dynamic>{
          'question': questions[currentQuestionIndex!],
          'onChoiceSelected': onChoiceSelected,
        },
      );
      // removes the index so that it doesn't get repeated.
      _choosable.remove(currentQuestionIndex);
    } catch (e) {
      // An error has occurred, check if the quiz is completed.
      if (_choosable.length == 0) {
        _completeQuiz();
      } else {
        // An unexpected error has occurred.
        _nav.pushReplacementNamed(errorRoute, arguments: {'error': e});
      }
    }
  }

  /// Adds the indices of all unanswered questions to [_choosable].
  void _filterAnswered() {
    // questionIndex is needed since the user progress is stored
    // as a map of quiz ids to bools. The quiz id is a long randomly
    // generated string, so it can't be used to index a list. However,
    // the questions will be in the same order as is returned from
    // [Api.getQuestions()].
    int questionIndex = 0;
    Map<String, bool> progress = _user.getProgressForQuiz(quiz.id);
    progress.forEach((id, isAnswered) {
      if (!isAnswered) {
        _choosable.add(questionIndex);
      }
      questionIndex++;
    });
  }

  /// Updates the user progress so that is persists even after
  /// the nested flow is left.
  void _markCorrect(int index) {
    String quizId = quiz.id;
    String questionId = questions[index].id;
    _user.setQuestionAnswered(quizId, questionId);
  }

  void _completeQuiz() {
    // Don't need to clear snackbars here since they are already
    // cleared in [pushNextQuestion].
    _nav.nestedPushReplacementNamed(questionsRouteFinished);
  }

  void onChoiceSelected(Choice choice, [SnackBar? snackBar]) {
    if (choice.isCorrect) {
      _markCorrect(currentQuestionIndex!);
      pushNextQuestion();
    } else {
      _snackBar.showSnackBar(snackBar!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppbar(),
      body: ScaffoldMessenger(
        key: _snackBar.nestedKey,
        child: Navigator(
          key: QuestionsViewModel.nestedNavKey,
          onGenerateRoute: nestedGenerateRoute,
          initialRoute: questionsRouteStart,
        ),
      ),
    );
  }

  PreferredSizeWidget _createAppbar() {
    return AppBar(
      title: Text(quiz.title),
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () {
          // Clears snackbars so that they don't render on other pages.
          _snackBar.removeCurrentSnackBar();
          _nav.pop();
        },
      ),
    );
  }
}

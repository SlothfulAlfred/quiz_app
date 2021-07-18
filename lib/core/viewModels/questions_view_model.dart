import 'dart:math';

// Importing material.dart only for the type SnackBar.
import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';
import 'package:quiz_app/core/services/navigation_service.dart';
import 'package:quiz_app/core/services/snackbar_service.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/routing_constants.dart';

import 'base_model.dart';

class QuestionsViewModel extends BaseModel {
  final Api _api = locator<Api>();
  final NavigationService _nav = locator<NavigationService>();
  final SnackBarService _snackBar = locator<SnackBarService>();

  late List<Question> questions;
  final Quiz quiz;
  final AnimationController controller;

  Question? currentQuestion;
  Question? nextQuestion;

  bool finished = false;

  QuestionsViewModel({required this.quiz, required this.controller}) {
    _onInit(quiz.id);
  }

  void _onInit(String id) async {
    setState(ViewState.busy);
    questions = await _api.getQuestions(id);

    // Checks if the quiz is already completed
    if (questions.length == 0) {
      _completeQuiz();
      return;
    }
    // runs pushNextQuestion at least twice in order to
    // make sure currentQuestion is not null.
    while (currentQuestion == null) {
      pushNextQuestion();
    }
    setState(ViewState.idle);
  }

  void onChoiceSelected(Choice choice, [SnackBar? snackBar]) {
    if (choice.isCorrect) {
      pushNextQuestion();
    } else {
      _snackBar.showSnackBar(snackBar!);
    }
  }

  Future _driveAnimation() async {
    try {
      await controller.forward().orCancel;
    } on TickerCanceled {
      // View was disposed, catch error.
      return;
    }
  }

  Future pushNextQuestion() async {
    try {
      int x = Random().nextInt(questions.length);
      await _driveAnimation();
      _setQuestion(questions[x]);
      questions.removeAt(x);
    } catch (e) {
      // An error has occurred, check if the quiz is completed.
      if (questions.length == 0 && nextQuestion == null) {
        _completeQuiz();
      } else if (questions.length == 0) {
        // The quiz is not completed, check if it is the last question.
        await _driveAnimation();
        _setQuestion(null);
      } else {
        // An unexpected error has occurred.
        _nav.pushReplacementNamed(errorRoute, arguments: e);
      }
    }
  }

  void _completeQuiz() {
    finished = true;
    notifyListeners();
  }

  void _setQuestion(Question? newQuestion) {
    currentQuestion = nextQuestion;
    nextQuestion = newQuestion;
    notifyListeners();
  }
}

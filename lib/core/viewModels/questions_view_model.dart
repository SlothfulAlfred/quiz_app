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

  List<Question>? questions;
  final String id;

  // flags
  Question? currentQuestion;
  bool finished = false;

  QuestionsViewModel({required this.id}) {
    _onInit(id);
  }

  void _onInit(String id) async {
    setState(ViewState.busy);
    questions = await _api.getQuestions(id);
    setState(ViewState.idle);
  }

  void onChoiceSelected(Choice choice, [SnackBar? snackBar]) {
    if (choice.isCorrect) {
      // TODO: implement transition to next question
    } else {
      _snackBar.showSnackBar(snackBar!);
    }
  }

  void setQuestion() {
    setState(ViewState.busy);
    try {
      int x = Random().nextInt(questions!.length);
      currentQuestion = questions![x];
      questions!.removeAt(x);
    } catch (e) {
      if (questions!.length == 0) {
        finished = true;
      } else {
        _nav.pushReplacementNamed(errorRoute, arguments: e);
      }
    }
  }
}

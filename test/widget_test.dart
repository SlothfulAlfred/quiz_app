import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:test/test.dart';

void main() {
  test('Question - Test Default Constructor', () {
    var question =
        Question(quizId: '', question: '', choices: Map<String, dynamic>());
    expect(question is Question, true);
  });
  test('Question - Testing fromJson Constructor', () {
    Map json = {
      'quizId': '',
      'question': '',
      'choices': {
        '0': {
          'isCorrect': false,
          'hintText': null,
          'text': '',
        },
        '1': {
          'isCorrect': true,
          'hintText': null,
          'text': '',
        }
      }
    };
    var question = Question.fromJson(json);
    expect(question is Question, true);
  });
  test('Choice - Testing Default Constructor', () {
    var choice = Choice(
      text: '',
      isCorrect: false,
      hintText: null,
    );
    expect(choice is Choice, true);
  });
  test('Choice - Testing fromJson Constructor', () {
    Map<dynamic, dynamic> json = {
      'text': '',
      'isCorrect': false,
      'hintText': null,
    };
    var choice = Choice.fromJson(json);
    expect(choice is Choice, true);
  });
}

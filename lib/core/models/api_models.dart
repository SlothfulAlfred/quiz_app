import 'package:firebase_auth/firebase_auth.dart';

class Quiz {
  final int id;
  final String topic;
  final Map<int, Choice> choices;

  Quiz({required this.id, required this.topic, required this.choices});
}

class Choice {
  final int id;
  final bool isCorrect;
  final String text;
  final String? hintText;

  Choice(
      {required this.id,
      required this.isCorrect,
      required this.text,
      this.hintText});
}

class LoginResponse {
  final bool success;
  final FirebaseAuthException? error;

  LoginResponse({required this.success, this.error});
}





/// SAMPLE QUESTION DOCUMENT IN DATABASE
/// 'id' is the question identifier
/// 'question' is the text containing the actual question to be asked
/// 
/// 'choices' is a map of {int: map}, the keys are the id of the choices
/// while the values are maps representing choices. It is represented
/// this way since choices will *always* be displayed together with 
/// their corresponding questions, so if they were put into subcollections
/// The database would have to be queried before each question is displayed.
/// 
/// The fields of the nested maps are:
/// - 'text': the text to be displayed 
/// - 'is_correct': flag marking whether the choice is correct
/// - 'hint_text': text to be displayed if a wrong answer is chosen, 
///                null if the choice is correct.
/// ---------------------------------------------------------------------
/// "id": 0
/// "question": "What primitive type represents text in dart?"
/// choices: {
///   0: {
///     "text": 'int',
///     "is_correct": false,
///     "hint_text": 'type int is used to represent integers (-1, 0, 1, 2...)',
///   },
/// 
///   1: {
///     "text": 'double',
///     "is_correct": false,
///     "hint_text": 'type double is used to represent decimal numbers (0.01, 2.343...)',
///   },
/// 
///   2: {
///     "text": 'String',
///     "is_correct": true,
///     "hint_text": null,
///   },
/// 
///   3: {
///     "text": 'bool',
///     "is_correct": false,
///     "hint_text": 'type bool is used to represent true/false values',
///   },  
/// }
/// -------------------------------------------------------------------------
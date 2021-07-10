import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';

/// Represents a question of a quiz.
class Question {
  final int id;
  final int quizId;
  final String question;
  final Map<int, Choice> choices;

  Question({
    required this.id,
    required this.quizId,
    required this.question,
    required this.choices,
  });
}

/// Represents a possible answer for a question.
class Choice {
  final int id;
  final bool isCorrect;
  final String text;
  final String? hintText;

  Choice({
    // TODO: consider removing the 'id' field from Choice since it may not be needed
    required this.id,
    required this.isCorrect,
    required this.text,
    this.hintText,
  });
}

/// Represents a quiz.
class Quiz {
  final int id;
  final String title;
  final String imagePath;
  final String description;
  final int length;

  Quiz({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.length,
  });
}

/// Stores information about a user.
class User {
  final String uid;
  final String username;
  final String email;
  final String profilePicturePath;
  final Progress progress;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePicturePath,
    required this.progress,
  });
}

/// Represents how far a user has progressed in the quizzes.
class Progress {
  final Map<int, Map<int, bool>> _progress;

  UnmodifiableMapView get progress => UnmodifiableMapView(_progress);

  Progress(this._progress);
  Progress.none() : _progress = Map();
}

/// Utility class to be returned from authentication attempts.
class LoginResponse {
  final bool success;
  final FirebaseAuthException? error;

  LoginResponse({required this.success, this.error});
}






/// SAMPLE QUIZ DOCUMENT IN DATABASE
/// 
/// 
/// -------------------------------------------------------------
/// 'id': 0
/// 'title': "Programming Languages"
/// 'image': "https://some/path/to/the/firebase/cloud/storage/images/quiz_$id.png"
/// 'description': "This quiz tests your knowledge about common programming
///                 languages such as Dart, C++, python and more!"
/// 'length': 5
/// -------------------------------------------------------------


/// SAMPLE USER DOCUMENT IN DATABSE
/// 'uid' is the unique user id generated by Firebase auth
/// 'username' is the user's display name
/// 'email' is the user's email
/// 'profilePicture' is a link to the user's profile picture which will
/// be stored on Firebase cloud storage  
/// 'progress' is a map of the user's progress in the quizzes
/// with the format {  
///   quiz_id: {
///     question_id: is_completed,
///   }
/// }
/// which is a map of {int, map of {int, bool}}.  
/// 
/// This will be read whenever the user opens the home page 
/// (where they see the quizzes), and will be updated whenever the
/// user answers a question correctly. The update will be a local update
/// and the data will be saved to the database upon logout (or a save dialog) 
/// to reduce the number of writes.
/// --------------------------------------------------------------
/// 'uid': 0000000000000001 
/// 'username': 'sample_username'
/// 'email': 'sample@email.com'
/// 'profilePicture': 'https://some/path/to/the/firebase/cloud/storage/images/$uid.png'
/// 'progress': {  
///   0: {
///     0: true,
///     1: false,
///     2: true,
///     3: false, 
///     4: false,
///   },
///   1: {
///     0: true,
///     1: true,
///     2: true,
///     3: true,
///     4: true,
///   },
/// }
/// ------------------------------------------------------------------



/// SAMPLE QUESTION DOCUMENT IN DATABASE
/// 'id' is the question identifier
/// 'question' is the text containing the actual question to be asked
/// 'quiz_id' is the associated quiz
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
/// "quiz_id": 0
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
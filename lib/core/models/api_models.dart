import 'dart:collection';

/// Represents a question of a quiz.
class Question {
  final String quizId;
  final String id;
  final String question;
  final Map<String, Choice> choices;

  UnmodifiableListView<Choice> get choicesList {
    List<Choice> temp = [];
    choices.forEach((_, value) {
      if (value is Choice) {
        temp.add(value);
      }
    });
    return UnmodifiableListView(temp);
  }

  Question({
    required this.quizId,
    required this.question,
    required this.id,
    required Map<String, dynamic> choices,
  }) : choices = choices.cast<String, Choice>();

  Question.fromJson(Map json)
      : quizId = json['quizId'],
        id = json['id'],
        question = json['question'],
        choices = json['choices']
            .map((_, choice) => MapEntry(_.toString(), Choice.fromJson(choice)))
            .cast<String, Choice>();
}

/// Represents a possible answer for a question.
class Choice {
  final bool isCorrect;
  final String text;

  /// The text to be displayed if an incorrect answer is chosen, leave
  /// null if [isCorrect] is true.
  final String? hintText;

  Choice({
    required this.isCorrect,
    required this.text,
    this.hintText,
  });

  Choice.fromJson(Map json)
      : isCorrect = json['isCorrect'],
        text = json['text'],
        hintText = json['hintText'];
}

/// Represents a quiz.
class Quiz {
  final String id;
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

  Quiz.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        imagePath = json['image'],
        description = json['description'],
        length = json['length'];
}

/// Stores information about a user.
class User {
  final String uid;
  final String username;
  final String email;
  final String? profilePicturePath;
  final Progress progress;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePicturePath,
    required this.progress,
  });

  // Setters
  set username(String newUsername) => username = newUsername;
  set profilePicturePath(String? newPic) => profilePicturePath = newPic;

  /// Creates a User object from a Map.
  User.fromJson(Map json)
      : uid = json['uid'],
        username = json['displayName'],
        profilePicturePath = json['profilePicture'],
        progress = Progress(json['progress']),
        email = json['email'];

  /// Creates an anonymous user.
  User.anonymous()
      : uid = '',
        username = '',
        email = '',
        profilePicturePath = '',
        progress = Progress.none();

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': username,
      'profilePicture': profilePicturePath,
      'progress': progress.progress,
      'email': email,
    };
  }
}

/// Represents how far a user has progressed in the quizzes.
///
/// Parameter should be in the format Map<String, List<String>> where
/// the key of the [Map] is the quiz ID and the value is a list
/// containing the ID's of all completed questions.
class Progress {
  final Map<String, List<String>> _progress;

  get progress => _progress;

  Progress(Map<String, dynamic> progress) : _progress = {} {
    for (String key in progress.keys) {
      var temp = progress[key];
      _progress[key] = List<String>.from(temp!);
    }
  }

  Progress.none() : _progress = <String, List<String>>{};
}

/// Utility class to be returned from authentication attempts.
class LoginResponse {
  final bool success;
  final Exception? error;
  final String? uid;

  LoginResponse({required this.success, this.error, this.uid});
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

// 0-----------------------------------------------------------0
// |                  NOT APPLICABLE ANYMORE                   |
// 0-----------------------------------------------------------0
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
/// 'choices' is a map of {String: map}, the keys are the id of the choices
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
/// "id": '00'
/// "quiz_id": '0'
/// "question": "What primitive type represents text in dart?"
/// choices: {
///   '0': {
///     "text": 'int',
///     "is_correct": false,
///     "hint_text": 'type int is used to represent integers (-1, 0, 1, 2...)',
///   },
///
///   '1': {
///     "text": 'double',
///     "is_correct": false,
///     "hint_text": 'type double is used to represent decimal numbers (0.01, 2.343...)',
///   },
///
///   '2': {
///     "text": 'String',
///     "is_correct": true,
///     "hint_text": null,
///   },
///
///   '3': {
///     "text": 'bool',
///     "is_correct": false,
///     "hint_text": 'type bool is used to represent true/false values',
///   },
/// }
/// -------------------------------------------------------------------------

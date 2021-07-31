import 'package:quiz_app/core/models/api_models.dart';
import 'package:test/test.dart';

void main() {
  group('Question - ', () {
    test('Test Default Constructor', () {
      var question = Question(
          quizId: '', id: '', question: '', choices: Map<String, dynamic>());
      expect(question is Question, true);
    });
    test('Testing fromJson Constructor', () {
      Map json = {
        'quizId': '',
        'id': '',
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
      expect(question.choices['0']!.isCorrect, false);
    });
  });

  group('Choice - ', () {
    test('Testing Default Constructor', () {
      var choice = Choice(
        text: '',
        isCorrect: false,
        hintText: null,
      );
      expect(choice is Choice, true);
    });
    test('Testing fromJson Constructor', () {
      Map<dynamic, dynamic> json = {
        'text': '',
        'isCorrect': false,
        'hintText': null,
      };
      var choice = Choice.fromJson(json);
      expect(choice is Choice, true);
      expect(choice.hintText == null, true);
    });
  });

  group('User - ', () {
    test('Testing User Default Constructor', () {
      var user = User(
        email: '',
        uid: '',
        username: '',
        profilePicturePath: '',
        progress: Progress.none(),
      );
      expect(user is User, true);
      expect(user.email, '');
    });

    test('Testing fromJson Constructor', () {
      var json = {
        'email': '',
        'uid': '',
        'displayName': '',
        'profilePicture': '',
        'progress': {
          '0': {
            '0': true,
            '1': true,
            '2': true,
            '3': false,
          },
          '1': {
            '0': false,
            '1': false,
          },
        },
      };
      var user = User.fromJson(json);
      expect(user is User, true);
      expect(user.progress.progress['0']['0'], true);
    });

    test('Testing Anonymous Constructor', () {
      var user = User.anonymous();
      expect(user is User, true);
      expect(user.email, '');
      expect(user.uid, '');
      expect(deepContainsValue(user.progress.progress, true), false);
    });
  });

  group('Progress - ', () {
    test('Testing Default Constructor', () {
      var json = {
        '0': {
          '0': true,
          '1': true,
          '2': true,
          '3': false,
        },
        '1': {
          '0': false,
          '1': false,
        },
      };
      var progress = Progress(json);
      expect(progress is Progress, true);
      expect(progress.progress['0']['0'], true);
      expect(progress.progress['1']['0'], false);
    });

    test('Testing None Constructor', () {
      var progress = Progress.none();
      expect(deepContainsValue(progress.progress, true), false);
    });
  });

  group('Quiz - ', () {
    test('Testing Default Constructor', () {
      var quiz = Quiz(
        id: '',
        title: '',
        imagePath: '',
        description: '',
        length: 0,
      );
      expect(quiz is Quiz, true);
      expect(quiz.length, 0);
    });

    test('Testing fromJson Constructor', () {
      var json = {
        'id': '',
        'title': 'title',
        'image': '',
        'description': '',
        'length': 0,
      };
      var quiz = Quiz.fromJson(json);
      expect(quiz is Quiz, true);
      expect(quiz.id.isEmpty, true);
      expect(quiz.title.isNotEmpty, true);
    });
  });
}

/// [Map.containsValue] is a shallow function, meaning that it doesn't
/// check whether nested maps contain the given value. This function
/// has the same effect except it also checks contents of nested maps.
bool deepContainsValue(Map map, dynamic value) {
  // Assume that the value is not contained by default.
  bool result = false;
  for (var item in map.values) {
    // If the value is contained, immediately return true.
    // This prevents the result being overriden later.
    if (result == true) return true;

    // If the item is a [Map], recursively call the function.
    // The recursive call isn't returned because this would only check
    // the first nested map without checking the rest of the Map.
    if (item is Map) {
      result = deepContainsValue(item, value);
    } else if (item == value) {
      // Another base case, reached if the value hasn't been found and
      // there is no more nesting.
      return true;
    }
  }
  // If this has been reached, result will be false.
  return result;
}

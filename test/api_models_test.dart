import 'package:quiz_app/core/models/api_models.dart';
import 'package:test/test.dart';

void main() {
  group('Question - ', () {
    test('Test Default Constructor', () {
      var question =
          Question(quizId: '', question: '', choices: Map<String, dynamic>());
      expect(question is Question, true);
    });
    test('Testing fromJson Constructor', () {
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
      expect(user.progress.progress.isEmpty, true);
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
      expect(progress.progress.isEmpty, true);
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
